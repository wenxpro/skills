# 行为评估与证伪

> 结构审计回答「写得对不对」；行为评估回答「加载后是否更好」。
> 本文件是 `skill-audit` 的行为评估子流程，不替代 `references/trigger-cases.md` 的触发回归，也不替代 `validation-design` 的验证设计方法。

## 何时使用

- 新增或修改 skill，且改动涉及 `description`、触发边界、职责重叠或核心规则
- 两个以上 skill 的触发词重叠，怀疑会误触发或漏触发
- 用户要求「验证这个 skill 是否有效」「对抗测试」「证伪」
- 合并前需要给「有效」结论，而不是只给结构结论

不适用：

- 只改错别字、链接或格式，结构审计足够
- 项目文档集审核 → `docs-audit`
- skill 内容的多角色评审 → `review`

## 能证明与不能证明

能回答：

- 触发是否正确：positive / negative / ambiguous / conflict
- 加载后任务成功、指令遵循、输出质量是否优于对照
- 是否引入错误、冲突、过度加载或成本上升
- 哪些边界和失败用例还没有覆盖

不能回答：

- 绝对证明「合理有效」；样本、模型和上下文都会限制结论
- 替代真人判断或长期线上效果
- 用一次运行代表稳定行为

## 评估层级

| 层级 | 做法 | 能回答 | 成本 |
|---|---|---|---|
| L1 结构 | `scripts/check-skills.sh` + 本 skill 的结构/分层审计 | 写得对不对 | 低 |
| L2 触发回归 | `references/trigger-cases.md` + skill 调用记录 | 该不该加载 | 中 |
| L3 消融 | with / without skill 对比 | 加载后是否更好 | 中高 |
| L4 盲评 | 随机顺序 + 盲评 rubric | 质量是否提升 | 高 |
| L5 真人复核 | 抽样人工判断 | 结论是否可信 | 最高 |

默认至少 L1 + L2；涉及核心规则或职责重叠时到 L3；要宣称「有效」时到 L4 或 L5。

## 最小流程

1. **写主张**：这个 skill 应该让什么变好？什么结果会证明它无效？
2. **建用例**：positive / negative / ambiguous / conflict；每个 skill 5–10 条；留 20% holdout；记录期望加载和禁止加载的 skill。
3. **定变体**：with target / without target / with competing；同一 prompt、同一模型、同一工具权限；2–3 次运行；记录 seed、温度、模型版本。
4. **观测**：skill 调用记录、输出、token、延迟；触发测试用小模型/短上下文，质量测试用目标模型/真实上下文。
5. **评分**：触发 precision/recall、wrong-skill rate、任务成功、指令遵循、质量 rubric、成本；能用确定性检查就用，不能才用盲评。
6. **证伪**：主动找「加载后更差」「该触发没触发」「不该触发却触发」「两个 skill 冲突」的反例；失败用例必须回写 `references/trigger-cases.md` 或 `description`。
7. **决策**：通过 / 修改 / 合并 / 拆分 / 退役；没有失败判据的评估不算通过。

## 最小一轮

1. 选一个 skill 或一个触发重叠簇。
2. 写 10–20 条用例：positive 5–8、negative 5–8、ambiguous/conflict 2–4；留 20% holdout。
3. 跑 2 个变体（with / without）各 2 次；有竞争 skill 时加第 3 组。
4. 记录 skill 调用、任务成功、质量、token/延迟。
5. 输出 `templates/eval-report.md`；失败用例回写 `references/trigger-cases.md` 或 `description`。

## 用例格式

| 字段 | 说明 |
|---|---|
| id | 唯一编号 |
| prompt | 用户输入，尽量像真实任务 |
| type | positive / negative / ambiguous / conflict / boundary |
| expect | 期望加载的 skill；没有则写 `none` |
| forbid | 不应加载的 skill |
| check | 确定性检查或评分 rubric |
| holdout | 是否留作 holdout |

## 指标

| 指标 | 定义 | 用途 |
|---|---|---|
| trigger precision | 加载的 skill 中相关比例 | 误触发 |
| trigger recall | 应加载的 skill 中实际加载比例 | 漏触发 |
| wrong-skill rate | 加载了禁止 skill 的用例比例 | 冲突与边界 |
| task success | 按用例判据通过比例 | 有效性 |
| adherence | 是否遵守 skill 的关键规则 | 指令遵循 |
| quality | 盲评 rubric 分数 | 输出质量 |
| cost | token / 延迟 / 加载 skill 数 | 可接受性 |

## 评分与盲评

- 触发测试优先用确定性检查：记录实际加载的 skill ID，与 `expect` / `forbid` 对比。
- 质量测试用 rubric，至少 3 档：明显更好 / 无差异 / 明显更差；评委不知道变体。
- 同一评委不要同时看期望答案和变体标签。
- 关键结论抽 10–20% 人工复核；优先复核失败用例和边界用例。

## 决策规则

- **通过**：L2 触发无禁止项；L3 至少不劣于对照；关键用例有改善；失败用例有解释。
- **修改**：触发或规则有可定位问题；失败用例能回写到 `description`、`references/trigger-cases.md` 或正文。
- **合并/拆分**：两个 skill 在多数用例同时加载且职责重叠；按 `references/consolidation.md` 判断。
- **退役**：加载后稳定变差、成本高、无独特职责。
- **未评估**：没有行为证据；不得写「有效」。

## 反模式

- 只跑结构检查就宣称 skill 有效
- 只用正例，没有 negative / ambiguous / conflict
- 没有 holdout，按用例反复调 `description`
- 没有对照，只看加载后的输出
- 用写 skill 的同一模型自评，且不盲评
- 把触发测试和质量测试混成一个分数
- 忽略 token、延迟和加载 skill 数量
- 失败用例不回收，下一轮继续重复

## 与现有文件的关系

- `references/trigger-cases.md`：触发回归的种子用例；评估失败回写到这里。
- `references/behavior-policy.md`：多轮行为与打断策略的判据；行为用例复用。
- `validation-design`：失败判据、反事实、证据层级的通用方法；本文件只做 skill 级应用。
- `templates/eval-report.md`：评估报告模板。
