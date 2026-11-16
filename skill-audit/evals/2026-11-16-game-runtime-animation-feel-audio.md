# Skill 评估 — Godot / 动画 / 反馈 / 音频

> 日期：2026-11-16
> 版本 / commit：本轮新增 skills（godot-game-runtime、game-animation-rig、game-feel、game-audio）
> 模型 / 工具：无模型运行；本地结构检查 + 人工触发表审
> 评估人：agent
> 结论：L1 通过；L2 人工表审通过；L3/L4 未评

## 1. 主张与失败判据

- 这个 skill 应该让什么变好：
  - 引擎运行、3D 动画、打击反馈、音频四个领域能各自触发，不互相抢
  - 项目细节留在项目文档，skill 只保留可复用规则
- 什么结果会证明它无效：
  - 同一 prompt 同时触发 2 个以上领域 skill 且无法分工
  - 动画/反馈/音频问题被错误路由到 `game-docs` 或 `ui-baseline`
  - 结构检查或术语扫描失败
- 本评估不能证明：
  - 加载后任务质量是否提升（L3/L4）
  - 不同模型/上下文下的稳定触发
  - 真实项目中的长期效果

## 2. 用例集

| 类型 | 数量 | 说明 |
|---|---:|---|
| positive | 6 | 每个新 skill 至少 1 条 |
| negative | 4 | 应触发相邻 skill 或 none |
| ambiguous | 2 | 跨领域但可分工 |
| conflict | 2 | 同时涉及两个领域 |
| holdout | 2 | 未用于改 description |

用例明细：

| ID | prompt | type | expect | forbid | check | holdout |
|---|---|---|---|---|---|---|
| R1 | Godot headless 回归怎么搭，音频总线怎么建 | positive | godot-game-runtime | game-docs、ui-baseline | 结构/命令层 | 否 |
| R2 | 3D 模型脚底浮空、剑反向、重定向后动作变形 | positive | game-animation-rig | game-combat-model、game-feel | 资产/脚底/挂点 | 否 |
| R3 | 命中反馈太糊，hitstop/震屏/闪白怎么分层 | positive | game-feel | game-combat-model、ui-baseline | 反馈层/预算 | 否 |
| R4 | 游戏总线怎么分，音乐循环、音量静音持久化 | positive | game-audio | godot-game-runtime、ui-baseline | 音频架构 | 否 |
| R5 | 多分辨率截图和前后对比怎么设计 | positive | validation-design（visual-evidence） | ui-baseline、game-docs | 证据矩阵 | 是 |
| R6 | 程序化低模代理/护甲化怎么做 | positive | game-animation-rig（procedural-proxy） | ui-baseline、game-combat-model | 代理规则 | 是 |
| N1 | 攻击频率/伤害/克制/TTK 怎么定 | negative | game-combat-model + game-systems-balance | game-feel、game-animation-rig | 战斗模型 | 否 |
| N2 | UI token/组件状态/无障碍 | negative | ui-baseline | godot-game-runtime、game-feel | UI 规范 | 否 |
| N3 | 这一步该提交还是开 worktree | negative | git-commit / worktree-workflow | game-audio、game-feel | 仓库流程 | 否 |
| N4 | 文档集有没有矛盾/过时 | negative | docs-audit | game-docs、skill-audit | 文档审核 | 否 |
| A1 | 动画接触帧和打击反馈怎么对齐 | ambiguous | game-animation-rig + game-feel | ui-baseline | 实现 vs 预算分工 | 否 |
| A2 | 音频总线在 Godot 里怎么接、混音怎么定 | ambiguous | godot-game-runtime + game-audio | game-feel、ui-baseline | 引擎 vs 音频设计 | 否 |
| C1 | 改动画后接触帧漂移，顺手想加震屏 | conflict | game-animation-rig + game-feel | game-combat-model、ui-baseline | 先修接触事实源，再谈反馈 | 否 |
| C2 | Windows 下中文乱码 + 并行提交 | conflict | git-commit（windows-hygiene） | game-audio、godot-game-runtime | 编码/仓库卫生 | 否 |

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

人工表审说明：R1–C2 均能按 description/不适用节路由到预期 skill；A/C 用例需要两个 skill 分工，但没有出现同一职责重复。L3/L4 没有运行，因此不能声明「加载后有效」。

## 5. 失败与反例

| ID | 现象 | 影响 | 归因 | 回写位置 |
|---|---|---|---|---|
| — | 未发现结构性误触发 | — | — | — |

## 6. 结论与行动

- 决策：**L1 通过；L2 人工表审通过；L3/L4 未评**
- 必须改：无
- 建议改：
  - 后续用真实模型跑 R1–C2 的 with/without/competing 变体
  - 补一条「音频 + 反馈同时出现」的冲突用例
- 证据层级 / 置信度：结构 + 人工路由；低
- 下一轮只改：触发用例与 description，不改核心规则

## 7. 限制

- 没有模型运行、没有盲评、没有 token/延迟数据
- 只覆盖新增/相邻 skill，不覆盖全仓库
- 项目案例没有进入 skill 正文；通用规则可能仍需真实项目检验
