# 文档槽位映射

本文件把 7 个槽位映射到具体编号/文件。其他团队可整体替换，`SKILL.md` 不受影响。

## Game（00~05、07；06 为可选遗留槽位，配合 game-docs）

| 槽位 | 文件 |
|---|---|
| 入口 | `00-README.md` |
| 假设 | `01-run-brief.md` |
| 规则 | `02-design-spec.md` |
| 验收 | `03-acceptance.md` |
| 决策 | `04-adr/` |
| 证据 | `05-reviews/`（试玩结论并入评审；`06-playtests/` 可选） |
| 检查 | `07-checklists/` |

## Narrative（00~11；配合 narrative-docs）

| 槽位 | 文件 |
|---|---|
| 入口 | `00-README.md` |
| 假设 | `01-story-brief.md` |
| 规则 | `02-world-bible.md`、`03-characters.md`、`04-structure.md`、`05-scene-cards.md`、`06-voice-guide.md`、`07-continuity.md` |
| 验收 | `08-readthrough.md` |
| 决策 | `10-adr/` |
| 证据 | `09-readthroughs/` |
| 检查 | `11-checklists/` |

裁剪：短篇可只保留 `00 / 01 / 04 / 08`；长篇或分支剧本建议全量。

## Software（`docs/00-README.md` + 01~07 + 08-adr + 09-reviews + 10-evidence；配合 software-docs）

| 槽位 | 文件 |
|---|---|
| 入口 | `docs/00-README.md` |
| 假设 | `docs/01-PRD.md` |
| 规则 | `docs/02-ARCHITECTURE.md`、`03-INTERFACE.md`、`04-DATA.md`、`05-SECURITY.md`、`06-RUNBOOK.md` |
| 验收 | `docs/07-ACCEPTANCE.md` |
| 决策 | `docs/08-adr/` |
| 证据 | `docs/09-reviews/`、`docs/10-evidence/` |
| 检查 | `docs/07-ACCEPTANCE.md` 的 DoD；`docs/00-README.md` 的状态 |

裁剪：单机小工具可只用 `00 / 01 / 07`；有服务端或数据库再补 `02 / 03 / 04`；涉及账号、支付、PII、对外接口再补 `05` 与 `06`。
