# narrative-docs 标准与偏好

> 个人 / 团队偏好文件，可整体替换。槽位映射见 `docs-core/standards.md`。

## 文档语言

- 设计文档、评审、ADR：中文
- 角色名、术语、场景 ID：与项目术语表一致
- 代码 / 工具占位：英文
- 正文语言：按作品；文档语言不强制等于正文语言

## 评审

评审流程不在本 skill 内重复，使用 `review` skill：

- 流程：`review/references/workflow.md`
- 叙事角色：`review/profiles/narrative.md`
- 模板：`review/templates/review.md`

有效结论：通过 / 有条件通过 / 否决。每个角色必须给出理由与否决权；未通过的条件要有 owner 与截止时间。

## 优先级

> 状态与优先级语义以 `docs-core` 为准，本节只列 narrative profile 的具体判定。

- **P0**：故事承诺不成立、读者无法理解、连续性断裂、分支死局、人物动机不成立。
- **P1**：节奏、语气、边缘场景、可读性优化。
- P0 未解决，不进入下一阶段。功能 / 包优先级用 `High / Medium / Low`。

## 状态标记

与 `implementation-track` 共用：

- `◻` 未开始
- `🔄` 进行中
- `✅` 通过
- `❌` 失败（附原因）

## 默认阶段（可裁剪）

- **N0 概念**：00 / 01 + 关键 ADR
- **N1 结构**：02 / 03 / 04 + 评审
- **N2 初稿**：05 / 06 / 07
- **N3 修订**：08 / 09 + 修订记录
- **N4 试读 / 定稿**：试读证据 + 连续性审计

## 验收约定

- 不写“好看 / 感人 / 合理”；写可观察的读者行为或文本证据。
- 每条读者体验判据至少有一个证据来源。
- 试读记录保留原话与场景 ID / 页码，不只写总结。
- 分支剧本必须有收敛表与死局检查。
- 连续性冲突必须给出来源与修复状态。
- 样本不足写 `SKIP`，不算通过。

## 工具环境

- Markdown + Git；不绑定编辑器。
- 模板使用相对路径；不写本机绝对路径。
- 项目已有目录结构时先映射，不强制搬家。

## 相关 skill

- `docs-core`：槽位定义与编号映射
- `review`：通用评审流程；叙事使用 `profiles/narrative.md`
- `game-docs`：玩法、关卡、数值、平衡与游戏验收
- `software-docs`：软件项目文档；不用于剧本作品
- `experience-architecture`：产品表面与导航，不用于故事结构
- `validation-design`：假设、变量、失败判据、证据层级
- `docs-audit`：文档集审核
- `roadmap-planning`：阶段与里程碑规划
- `implementation-track`：验收状态与偏差记录
