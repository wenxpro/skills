# Skill 合并与拆分

> 目标：减少重复触发和上下文负担，但不把不同职责硬塞进一个大 skill。合并前先判断关系类型，再选改造方式。

## 1. 先判断关系类型

| 类型 | 特征 | 处理 |
|---|---|---|
| 同一职责的不同模式 | 触发句几乎一样；输出是同一种证据；一个只是另一个的包装或模式 | 合并 |
| 同一流程的不同阶段 | 顺序相邻，但触发、证据、失败处理不同 | 用 runbook 串起来，不合并 |
| 同一方法的不同领域 | 流程相似，但对象/领域不同 | 用 profile 或 reference，不合并 |

判断句：

> **如果两个 skill 的触发句可以互换，且输出是同一种证据，才可以合并。**
>
> **如果只是顺序相邻，但职责不同，用 runbook 串起来。**

## 2. 常见合并方式

| 方式 | 适用 | 做法 |
|---|---|---|
| 模式合并 | 一个 skill 是另一个的多仓库/多环境/多模式版本 | 主 skill 保留入口，模式细节放 `references/<mode>.md` |
| 伞形合并 | 两个 skill 都在处理同一个边界，只是方面不同 | 新建伞形 skill，原内容放两个 reference |
| runbook | 多个 skill 按固定顺序出现，但职责不同 | 在阶段 skill 下加 `references/<stage>-runbook.md` |
| profile | 流程相同，领域不同 | 主 skill 保留流程，领域细节放 profile/reference |
| 改名 | 名称容易和相邻 skill 混淆 | 改名 + 更新触发描述，不合并内容 |
| 抽公共模板 | 多个 skill 共享报告/检查格式 | 抽 `templates/` 或 `references/`，主体不合并 |

## 3. 合并判据

同时满足越多，越值得合并：

- 触发句可以互换。
- 输出是同一种证据。
- 一个 skill 是另一个的子集或模式。
- 合并后上下文总量下降，而不是上升。
- 合并后负向边界仍然清楚。
- 只有一个 owner 和一个事实源。

出现以下任一情况，不合并：

- 触发句不同，用户会按场景选择。
- 输出不同（代码 vs 文档 vs 验收）。
- 一个是阶段 playbook，另一个是可复用方法。
- 合并后需要同时加载大量无关内容。
- 合并后无法写清“不适用”。

## 4. 改造步骤

1. **收集触发句**：各 skill 的 description、README 入口、trigger-cases。
2. **列输出证据**：每个 skill 产出什么、写到哪里、谁验收。
3. **做共现分析**：哪些 skill 经常在同一任务中被同时加载；是顺序相邻还是同一职责。
4. **模拟合并后的 description**：如果一句话能覆盖两个 skill，才考虑合并。
5. **选改造方式**：模式合并、伞形、runbook、profile、改名、抽模板。
6. **迁移引用**：README、其他 skill 的交接表、trigger-cases、安装列表。
7. **保留边界**：合并后的 skill 必须写清“何时不用”和与相邻 skill 的分工。
8. **验证**：跑 `scripts/check-skills.sh`；改过 description 的跑 trigger-cases；检查相对链接。
9. **删除旧目录或保留一次迁移说明**：不要长期保留两个可触发入口。
10. **同步安装副本**：本机 `~/.agents/skills` 或项目级目录。

## 5. 重构模式

### 模式合并

适用：多仓库提交、单/多环境、单/多模型。

```text
git-commit/
├─ SKILL.md              # 单仓库 + 多仓库入口
├─ standards.md          # 单仓库 + 多仓库偏好
└─ references/
   └─ multi-repo.md      # 多仓库细节
```

规则：主 skill 只写两模式共用的规则；模式细节放 reference，避免主文件膨胀。

### 伞形合并

适用：工作区隔离 + 会话交接、创建 + 校验等同一边界的两面。

```text
session-boundary/
├─ SKILL.md              # 何时隔离、何时交接
├─ references/
│  ├─ worktree.md
│  └─ handoff.md
└─ templates/
```

规则：伞形 skill 只做路由和共同规则；不复制两个子主题的全部细节。

### runbook

适用：设计、交付、反馈这类阶段链路。

```text
delivery-stage/references/delivery-runbook.md
```

runbook 只写：

- 顺序：先做什么、后做什么。
- 输入/输出：每一步需要什么、产出什么。
- 什么时候调用哪个 skill。
- 失败/回退点。

不重复各 skill 的规则。

### 改名而不是合并

适用：名称混淆但职责不同。

例如：`review`（方案/里程碑评审）与 `code-review`（代码审查）不应合并；可以通过 description 和 trigger-cases 明确分工，必要时改名。

### 抽公共模板

适用：多个 audit/check skill 共享报告结构。

抽 `templates/audit-report.md`，不合并主体；每个 skill 保留自己的检查清单和负向边界。

## 6. 反模式

- 按“总是前后出现”合并阶段 skill。
- 把设计方法塞进阶段 playbook。
- 合并后 description 过宽，什么都触发。
- 合并后没有“不适用”清单。
- 保留两个可触发入口，长期靠用户猜。
- 只改内容，不迁移 README、交接表、trigger-cases 和安装副本。
- 合并后主文件变大，细节没有下沉到 reference。
- 为了减少 skill 数量而牺牲证据类型和验收边界。

## 7. 输出格式

一次合并/拆分评估至少报告：

| 项 | 内容 |
|---|---|
| 候选 | `<skill-a>` + `<skill-b>` |
| 关系类型 | 同一职责 / 同一流程 / 同一方法 |
| 合并判据 | 触发、输出、子集、上下文、边界 |
| 改造方式 | 模式合并 / 伞形 / runbook / profile / 改名 / 抽模板 |
| 迁移范围 | README、交接表、trigger-cases、安装副本 |
| 验证 | `check-skills.sh`、trigger-cases、链接检查 |
| 结论 | 合并 / 不合并 / 延后 |
