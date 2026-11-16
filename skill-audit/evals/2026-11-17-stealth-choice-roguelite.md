# Skill 评估 — 潜行 / 选择后果 / Roguelite

> 日期：2026-11-17
> 版本 / commit：本轮新增 skills（game-stealth、game-choice-consequence、game-roguelite）
> 模型 / 工具：无模型运行；本地结构检查 + 人工触发表审
> 评估人：agent
> 结论：L1 通过；L2 人工表审通过；L3/L4 未评

## 1. 主张与失败判据

- 这个 skill 应该让什么变好：
  - 潜行、选择后果、Roguelite 单局/构筑三个机制领域能各自触发
  - 不把敌人 AI、故事文档、数值平衡混进同一 skill
  - 项目机制只作为案例，不进入通用规则
- 什么结果会证明它无效：
  - 同一 prompt 同时触发两个机制 skill 且无法分工
  - 潜行问题被路由到 `game-ai-design`、选择问题被路由到 `narrative-docs`、Roguelite 问题被路由到 `game-systems-balance`
  - 结构检查或术语扫描失败
- 本评估不能证明：
  - 加载后任务质量提升（L3/L4）
  - 不同模型/上下文下的稳定触发
  - 真实项目中的长期效果

## 2. 用例集

| 类型 | 数量 | 说明 |
|---|---:|---|
| positive | 3 | 三个新 skill 各 1 条 |
| negative | 3 | 相邻 skill 的职责 |
| ambiguous | 2 | 跨领域但可分工 |
| conflict | 2 | 同时涉及两个领域 |
| holdout | 1 | 未用于改 description |

用例明细：

| ID | prompt | type | expect | forbid | check | holdout |
|---|---|---|---|---|---|---|
| S1 | 潜行怎么设计，敌人视野/警戒/追逃 | positive | game-stealth | game-ai-design、level-encounter-design | 检测/状态/风险 | 否 |
| S2 | 选择/后果/回访/结局怎么收 | positive | game-choice-consequence | narrative-docs、game-docs | 状态/回访/结局 | 否 |
| S3 | Roguelite 单局节奏/构筑/进化/卡池 | positive | game-roguelite | game-systems-balance、level-encounter-design | run/build/pool | 否 |
| N1 | 敌人 AI 为什么太神/不作弊 | negative | game-ai-design | game-stealth、game-roguelite | AI 感知/难度 | 否 |
| N2 | 故事/对白/世界观怎么写 | negative | narrative-docs | game-choice-consequence | 叙事文档 | 否 |
| N3 | 数值/经济/难度平衡怎么调 | negative | game-systems-balance | game-roguelite、game-stealth | 数值平衡 | 否 |
| A1 | 潜行关卡怎么放掩体和巡逻点 | ambiguous | game-stealth + level-encounter-design | game-ai-design | 需求 vs 布局 | 否 |
| A2 | 选择后果的数值/经济怎么平衡 | ambiguous | game-choice-consequence + game-systems-balance | narrative-docs | 状态 vs 数值 | 否 |
| C1 | Roguelite 构筑太强，顺便改战斗数值 | conflict | game-roguelite + game-systems-balance | game-combat-model | 结构 vs 数值 | 否 |
| C2 | 潜行失败后想加震屏/音效 | conflict | game-stealth + game-feel | ui-baseline | 风险/恢复 vs 反馈 | 是 |

## 3. 变体与运行

| 变体 | 加载 skill | 模型 | 运行次数 | seed / 温度 | 备注 |
|---|---|---|---|---|---|
| baseline | 无新 skill | 未运行 | 0 | — | 未做 L3 |
| target | 新 skill | 未运行 | 0 | — | 未做 L3 |
| competing | 相邻 skill | 未运行 | 0 | — | 未做 L3 |

## 4. 结果

| 指标 | baseline | target | competing | 结论 |
|---|---:|---:|---:|---|
| trigger precision | — | — | — | 人工表审：无误触发 |
| trigger recall | — | — | — | 人工表审：正例均命中 |
| wrong-skill rate | — | — | — | 0（表审） |
| task success | — | — | — | 未评 |
| adherence | — | — | — | 未评 |
| quality | — | — | — | 未评 |
| token / 延迟 | — | — | — | 未测 |

人工表审说明：S1–C2 能按 description/不适用节分工；A/C 用例需要两个 skill 协作，但没有同一职责重复。L3/L4 没有运行，因此不能声明「加载后有效」。

## 5. 失败与反例

| ID | 现象 | 影响 | 归因 | 回写位置 |
|---|---|---|---|---|
| — | 未发现结构性误触发 | — | — | — |

## 6. 结论与行动

- 决策：**L1 通过；L2 人工表审通过；L3/L4 未评**
- 必须改：无
- 建议改：
  - 后续用真实模型跑 S1–C2 的 with/without/competing 变体
  - 补「潜行 + 选择后果」同时出现的冲突用例
- 证据层级 / 置信度：结构 + 人工路由；低
- 下一轮只改：触发用例与 description，不改核心规则

## 7. 限制

- 没有模型运行、没有盲评、没有 token/延迟数据
- 只覆盖新增/相邻 skill，不覆盖全仓库
- 项目案例没有进入 skill 正文；通用规则可能仍需真实项目检验
