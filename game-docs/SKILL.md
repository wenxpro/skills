---
name: game-docs
description: 游戏项目文档体系：Run Brief、Design Spec、验收矩阵、ADR、试玩；含 M0/M1/M2 与 P0/P1 约定。槽位定义见 docs-core。适用于新游戏立项、写/重构 GDD、定义验收、记录试玩；不适用于纯代码、多屏幕体验架构（experience-architecture）、文档集审核（docs-audit）、规划（roadmap-planning）、跟踪（implementation-track）。Game docs / GDD / spec / acceptance / playtest.
---

# Game Docs

建立和维护游戏项目文档。槽位模型、单一事实源、变更流程见 `docs-core`；本 skill 只定义游戏特化部分与模板。

## 何时使用

- 新游戏项目：Run Brief / GDD / spec
- 把现有设计文档重构为可验收形式
- 定义验收标准 / QA 矩阵
- 记录和分析试玩
- 变更行为但不让 spec 漂移

不适用：纯代码修复、一次性设计问答、只想要代码、当前里程碑之后的内容。

## 核心规则

1. **先短后长**：循环没被验证前，Run Brief 保持一页；需要实现和验收时，才写精确的 Design Spec。
2. **只写当前里程碑**：当前循环未验证前，不提前写更长的单局模式、Boss、多角色。
3. **每条 P0 规则都有验收用例**：无法测试就不是规则。
4. **每个里程碑评审**：用 `review` skill 的 `profiles/game.md`；设计模式对照 `references/design-patterns.md`。
5. **不复制其他项目的内容**：模板只给结构，内容必须项目自己填。
6. **写进目标项目的 `docs/`**，不写进 skill 目录。
7. **多屏幕/入口先画体验架构。** 涉及首页、配置、暂停、结算、设置、试炼等产品表面时，先用 `experience-architecture` 写一页 Experience Map；游戏内容仍由本 skill 负责。

## 文档结构

编号与槽位映射见 `docs-core/standards.md` 的 Game 表（00~05、07；06 可选）。模板在 `references/templates/`：填法见各模板开头，完整流程见 `workflow.md`，完成检查见 `references/templates/07-checklists/checklists.md`。

跨项目的游戏设计模式见 `references/design-patterns.md`：单局结构、决策密度、威胁-成长、空间-胜负、变换规则、证据阶梯、可归因失败、表现-规则分离、平衡基准值。写 Spec 或评审时先对一遍，不要把模式当项目规则。

## 脚本（可选）

`scripts/` 提供脚手架与检查（Windows PowerShell）：

- `new-project-docs.ps1` — 复制模板并替换占位符
- `check-docs.ps1` — 检查必需文件、编号、链接、占位符

非 Windows 手动复制 `references/templates/` 即可。

## 边界

- 覆盖已有 `docs/` 前先问；未经允许不用 `-Force`
- 不猜项目名 / 类型 / 核心动词 / 里程碑
- 不把项目内容写进 skill（skill 只读）
- 结构变更后跑 `check-docs.ps1` 并报告结果
- 阶段路由：设计阶段用 `stage-router`；评审 `review`；规划 `roadmap-planning`
