---
name: narrative-docs
description: 长剧本/叙事项目文档体系：Story Brief、World Bible、Character Bible、Structure、Scene Cards、Voice Guide、Continuity、Revision、Read-through；基于 docs-core 的 7 类槽位。适用于长篇小说、电影/剧集剧本、视觉小说、叙事游戏的故事文档，以及把散乱设定重构为可维护文档；不适用于软件项目文档（software-docs）、游戏玩法/关卡/数值/平衡（game-docs）、产品表面/导航（experience-architecture）、文档集审核（docs-audit）、排期（roadmap-planning）、验收状态跟踪（implementation-track）。Narrative docs / story bible / screenplay / script.
---

# Narrative Docs

建立和维护长剧本/叙事项目的文档。槽位模型、单一事实源、变更流程见 `docs-core`；本 skill 只定义叙事特化部分与模板。

## 何时使用

- 新长篇小说 / 电影剧本 / 剧集 / 视觉小说 / 叙事游戏立项
- 现有设定散、人物走形、前后矛盾，需要收敛
- 写或重构 Story Brief、世界观、人物、结构、场景卡、语气、连续性、修订记录
- 准备试读/编辑评审，或把试读反馈转成可执行修改
- 故事行为变更，但不想文档漂移

不适用：

- 软件项目 → `software-docs`
- 游戏玩法、关卡、数值、平衡 → `game-docs`
- 产品表面、导航、状态所有权 → `experience-architecture`
- 文档集审核 → `docs-audit`
- 排期 → `roadmap-planning`
- 验收状态跟踪 → `implementation-track`

## 核心规则

1. **先短后长。** Story Brief 保持一页；结构与场景卡只在当前阶段需要时展开。
2. **事实与可能性分开。** `canon` 只写已确定的事实；草稿想法标为 `assumption`，不要混进连续性台账。
3. **只写当前阶段需要的。** 不提前写完全部人物小传、全部场景卡、全部世界观。
4. **场景有转折。** 每场写清目标、阻碍、转折、选择、后果；没有转折的场景合并或删。
5. **连续性可检查。** 称谓、时间、物件、知识状态、分支 flag 必须能对照，不靠记忆。
6. **验收是读者体验。** 用理解、情绪、人物 agency、分支收敛、连续性证据判定，不用软件 AC 语言。
7. **模板是脚手架。** 不强制作者填写；已有 Markdown 结构可以映射，不要求搬家。
8. **写进目标项目的文档目录。** 默认 `docs/`；已有文档结构则映射，不强制搬家；不写进 skill 目录。

## 行为策略

本 skill 为参考型：不主动打断、不主动切换任务、不主动建议停止或提交。只有在初始化项目文档或信息不足时，按 [workflow.md](workflow.md) 向用户提问；用户明确拒绝后不重复提示。

## 文档结构

编号与槽位映射见 [docs-core/standards.md](../docs-core/standards.md) 的 Narrative 表。模板在 `references/templates/`，流程见 [workflow.md](workflow.md)。

| 编号 | 文件 | 槽位 | 作用 |
|---|---|---|---|
| 00 | `00-README.md` | 入口 | 索引、状态、当前阶段 |
| 01 | `01-story-brief.md` | 假设 | 一句话、主题、承诺、范围、止损 |
| 02 | `02-world-bible.md` | 规则 | 世界规则、势力、地点、术语 |
| 03 | `03-characters.md` | 规则 | 人物欲望/恐惧/秘密/弧线/语气 |
| 04 | `04-structure.md` | 规则 | 幕/序列/节奏/分支/揭示 |
| 05 | `05-scene-cards.md` | 规则 | 每场目标/阻碍/转折/选择/后果 |
| 06 | `06-voice-guide.md` | 规则 | 叙述语气、台词差异、禁用表达 |
| 07 | `07-continuity.md` | 规则 | 时间线、称谓、物件、知识状态、flag |
| 08 | `08-readthrough.md` | 验收 | 读者理解/情绪/agency/收敛判据 |
| 09 | `09-readthroughs/` | 证据 | 试读/编辑/试玩记录 |
| 10 | `10-adr/` | 决策 | POV、结局、分支模型等叙事决策 |
| 11 | `11-checklists/` | 检查 | 初始化、场景、连续性、修订 DoD |
| 12 | `12-revision-log.md` | 证据 | 每轮修订：问题、改动、影响 |

裁剪：短篇可只保留 00/01/04/08；长篇或分支剧本建议全量。

## 与 game-docs 的边界

- `narrative-docs` 管故事：世界、人物、结构、场景、语气、连续性、试读。
- `game-docs` 管游戏：玩法循环、关卡、数值、平衡、验收矩阵、试玩。
- 叙事游戏两者都用：故事文档归本 skill，玩法/关卡/数值归 `game-docs`；交接物是场景卡、分支表与连续性台账。

## 评审

使用 `review` 的 `profiles/narrative.md`。角色至少包括：目标读者、故事编辑、连续性编辑、台词/语气编辑、制作/QA（如适用）、作者/决策人。

## 完成检查

- 初始化：00/01 存在，01 一页能说清故事；未确认前不写 02~07。
- 结构：每个场景有目标/阻碍/转折；分支有收敛与死局检查。
- 连续性：称谓、时间、知识状态、物件、flag 无未解释冲突。
- 试读：有记录、有原话、有行动项；不以“感觉好”代替证据。
- 修订：`12-revision-log.md` 有本轮记录；改动落回对应文档与连续性台账；不可逆叙事决定有 ADR。

## 边界

- 覆盖已有文档目录前先问；未经允许不覆盖。
- 不猜项目名、形式、长度、读者、当前阶段。
- 不把项目内容写进 skill（skill 只读）。
- 不把软件 PRD/架构/API/数据/安全模板塞进叙事项目。
- 设计阶段：`design-stage`；评审 `review`；验证 `validation-design`；规划 `roadmap-planning`。
