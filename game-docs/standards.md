# game-docs 标准与偏好

> 个人 / 团队偏好文件，可整体替换。槽位与编号映射见 `docs-core/standards.md`。

## 文档语言

- 设计文档、评审、ADR：中文
- 灰盒游戏 UI：英文占位（避免引擎默认字体缺中文字形）
- 代码注释：中文
- 正式版本地化：另开里程碑，不混进当前灰盒

## 评审

评审流程不在本 skill 内重复，使用 `review` skill：

- 流程：`review/references/workflow.md`
- 游戏角色：`review/profiles/game.md`
- 模板：`review/templates/review.md`

有效结论：通过 / 有条件通过 / 否决；归档状态（Superseded / Archived）见 `review/standards.md`。每个角色必须给出认可 / 条件 / 否决理由。

## 优先级

> 状态与优先级语义以 `docs-core` 为准，本节只列 game profile 的具体判定。

- **P0**：核心循环、必须修的错误、数据损坏、无法重开
- **P1**：体验、可读性、边缘优化、不阻塞发布的表现问题

P0 未全过，不进入下一里程碑。功能 / 包优先级用 `High / Medium / Low`。

## 状态标记

语义见 `docs-core`；与 `implementation-track` 共用：

- `◻` 未开始
- `🔄` 进行中
- `✅` 通过
- `❌` 失败（附原因）

## 默认里程碑

- **M0 立项**：01 / 02 / 03 / ADR / 评审
- **M1 灰盒**：可玩循环 + P0 验收 + 5 人试玩
- **M2 垂直切片**：内容、UI、音效、外部试玩

## 脚本环境

- 默认：Windows PowerShell 5.1+
- 非 Windows：手动复制 `references/templates/`，跳过 `scripts/`；或使用 PowerShell 7
- 路径示例统一用 `<target>`，不要在仓库里写死本机绝对路径

## 验收约定

- 固定种子必须可复现
- 每局日志包含：种子、结果、时长、统计、选择记录
- 性能测试必须记录机型 / CPU / GPU
- 验收用例不写「手感好」「看起来正常」

## 相关 skill

- `docs-core`：槽位定义与编号映射
- `experience-architecture`：产品表面、导航、状态所有权与生命周期
- `review`：通用评审流程；游戏使用 `profiles/game.md`
- `docs-audit`：文档集审核，可在评审前跑
- `roadmap-planning`：里程碑后的分期规划
- `implementation-track`：实现阶段的验收跟踪
- `code-digest` / `topic-research`：文档的外部输入
