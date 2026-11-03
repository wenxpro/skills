---
name: game-docs
description: 建立、维护游戏项目文档体系（Run Brief、Design Spec、验收矩阵、ADR、试玩）。游戏特化约定：M0/M1/M2 里程碑、P0/P1 验收语义、Run Brief 一页纸、试玩证据；槽位契约见 docs-core。适用于新游戏立项、写/重构 GDD 或行为规范、定义验收、记录试玩；不适用于纯代码修复、文档集审核（用 docs-audit）、跨版本规划（用 roadmap-planning）、实现跟踪（用 implementation-track）。Game docs / GDD / spec / acceptance / playtest.
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
2. **只写当前里程碑**：当前循环未验证前，不提前写 8 分钟模式、Boss、角色。
3. **每条 P0 规则都有验收用例**：无法测试就不是规则。
4. **每个里程碑评审**：用 `review` skill 的 `profiles/game.md`。
5. **不复制其他项目的内容**：模板只给结构，内容必须项目自己填。
6. **写进目标项目的 `docs/`**，不写进 skill 目录。

## 文档结构

编号与槽位映射见 `docs-core/standards.md` 的 Game 表（00~07）。模板在 `references/templates/`：填法见各模板开头，完整流程见 `workflow.md`，完成检查见 `references/templates/07-checklists/checklists.md`。

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
