---
name: worktree-workflow
description: 任务读写分流与 Git 工作树：只读讨论/调研留主工作区，任何写任务默认独立 worktree + 短分支，主工作区只做集成与验证。适用于要改代码/文档/配置/资源、讨论后开始落盘、并行会话、长任务、实验分支、方案对比、worktree 删除失败与目录自动恢复排查；不适用于纯只读讨论/调研、提交（git-commit）、代码审查（code-review）。
---

# 工作树工作流

目标：按「是否写」分流工作区。只读任务不制造分支；写任务不污染主工作区；合并的是分支，不是目录。

## 何时使用

- 要改代码、文档、配置、资源或生成物
- 讨论/调研已经结束，准备把结论落盘
- 多个会话同时写同一个仓库
- 长任务、实验分支、两套方案对比
- 需要让主工作区保持干净

不适用：

- 纯只读：阅读、讨论、调研、方案比较、代码解释
- 提交信息与提交历史 → `git-commit`
- 提交与推送 → `git-commit`（多仓库模式）
- 代码审查 → `code-review`
- 任务交接 → `session-handoff`

## 核心模型

- **判据是「是否写」，不是「是否并行」或「改动大小」。** 改一行文档也算写任务。
- 只读任务留在主工作区当前分支，不建 worktree。
- 写任务默认独立 worktree + 短分支；讨论转写时，先建 worktree，再落第一个文件。
- 主工作区停在集成分支（默认 `main`），只做拉取、合并、最终验证和清理；不直接编辑任务文件。
- 一个 worktree 一个分支一个写者；同一个分支不能同时检出到两个 worktree。
- 合并的是分支，不是 worktree 目录。
- 不确定会不会写：先按只读处理；出现第一个写操作前建 worktree。

## 读写分流

| 任务 | 默认位置 |
|---|---|
| 阅读、讨论、调研、方案比较、代码解释 | 主工作区，当前分支 |
| 改代码/文档/配置/资源、生成文件、格式化、迁移 | 独立 worktree + 短分支 |
| 讨论后决定写 | 先建 worktree，再落盘 |
| 读写混合 | 按写任务处理 |
| 多会话并行写 | 每个写会话独立 worktree |

## 主动行为

- 判定为写任务时，直接按默认流程建 worktree，不逐次询问。
- 判定为只读时不主动建；用户说「开始写」时，先建再编辑。
- 用户明确要求在主工作区写：说明影响后遵从，并记录例外。
- 删除有未提交改动的 worktree、处理语义冲突：必须先问。

## 写前检查

开始编辑前确认：

1. `git status --short --branch` 干净；有用户未提交改动时先识别并避开，不覆盖、不夹带。
2. 当前不在集成分支上直接写；在 `main` 上则先建 worktree。
3. 分支名、worktree 路径、owner、任务范围已确定。
4. 合并方式、验证命令、清理责任已确定。
5. 生成物、依赖、日志、本机配置不会进入提交。

任一项不满足，先补齐再编辑；不要用「先改一点再说」绕过。

## 创建流程

1. **确认是写任务**：只读讨论不要提前建 worktree。
2. **同步基线**：拉取集成分支，避免从过期基线开分支。
3. **建短分支**：按 `standards.md` 的命名建一个分支；一个分支一件事。
4. **建 worktree**：优先用 harness 的 worktree 工具；不可用时用 `git worktree add`。路径放在仓库外或已忽略目录，并避开编辑器的扫描范围（见「目录删不掉：进程占用」）。
5. **切换会话/目录**：需要把当前会话迁入时用 harness 的会话迁移工具；否则明确后续命令都在该目录执行。
6. **记录边界**：分支、worktree 路径、owner、目标、验证命令写入 handoff 或任务记录。

示例：

```sh
git -C <repo> fetch origin
git -C <repo> worktree add -b <type>/<slug> <path> <base>
```

## 并行规则

- 一个 worktree 只允许一个写者；其他会话只读。
- 不同会话尽量改不同模块/文件；共享接口、配置、内容表指定唯一 owner。
- 不在同一分支上开两个写会话；需要协作时用子分支 + 集成分支。
- 频繁同步集成分支，保持短分支。
- 只读会话可以共享主工作区，但不要改文件、不要切分支。
- 端口、数据库、外部服务、缓存不一定随 worktree 隔离；需要时单独分配。

## 合并

合并前：

1. 在特性 worktree 内提交并跑检查。
2. 同步集成分支；需要时 rebase 或 merge。
3. 走 `code-review`；高风险改动不得跳过。
4. 确认没有未提交文件和未跟踪的临时产物。

| 方式 | 适合 | 做法 |
|---|---|---|
| 依次合回集成分支 | 分支少、文件不重叠 | 主工作区 `merge --no-ff` 每个分支 |
| integration 分支 | 多分支同批功能 | 先合入 `integration/<topic>`，整体测试后再回集成分支 |
| rebase + fast-forward | 单人、追求线性历史 | 特性分支 rebase 后 fast-forward |
| PR/MR | 需要评审/记录 | push 分支，走远程合并 |

规则：

- 冲突在**合并分支时**解决，不在 worktree 之间同步目录。
- 机械冲突解决后必须跑检查；语义冲突停下来问用户。
- 不 rebase 共享的集成分支；不 force push 共享分支。
- 合并后主工作区复跑检查，确认集成分支结果一致。

## 目录删不掉：进程占用

**现象**：

- `git worktree remove <worktree-path>` 报 `Directory not empty`
- `rm -rf <worktree-path>` 之后目录重新出现，或残留少量文件
- `git worktree list` 已无该条目，目录却还在

**根因**：目录被删后仍有进程持有其下文件的句柄，进程继续写入即重建路径。常见持有者：

- 语言服务器：`sourcekit-lsp`（Zed / VS Code）、`SourceKitService`（Xcode）、`typescript-language-server`、`rust-analyzer`、`pyright`、`gopls`
- 构建与索引：`xcodebuild`、`swift build`、`tsc --watch`、`vite`、`gradle --continuous`、Spotlight（`mds`）
- 后台任务：测试 watcher、模拟器相关进程、编辑器插件

**判据**：`git worktree list` 无该条目、目录仍存在 = 有进程在写，不是 Git 记录损坏。此时不要反复 `rm -rf` 或 `worktree prune`。

**诊断**（按顺序）：

```sh
lsof +D <worktree-path>                  # 谁打开了该目录下的文件
lsof -p <pid>                            # 该进程的完整持有清单
ps -o pid,ppid,lstart,command -p <pid>   # 起始时间与父进程
```

`lsof +D` 有输出只说明文件被打开：只读句柄（`MODE` 为 `r`）不影响删除，写句柄或周期性写入才会让目录重建。先看 `lsof -p <pid>` 的 `MODE`，再删一次看目录是否重现，再决定要不要停进程。

**处理顺序**：

1. 先停写入方：只有只读句柄时直接删即可；报错或目录重建时，关闭打开该目录的编辑器窗口/工作区，或 `kill <pid>`（语言服务器被 kill 后编辑器会按需重启）。
2. 再删目录：`git worktree remove <worktree-path>`；确认无未提交改动后才可加 `--force`。
3. 复核：`lsof +D <worktree-path>` 无输出、`ls <worktree-path>` 不存在、`git worktree list` 无残留。
4. 只剩失效记录时才 `git worktree prune`。

**预防**：

- worktree 放在项目根目录之外（例如工具目录下的 `.worktrees/`），编辑器就不会把任务目录纳入扫描。
- 必须在项目内建时，把该路径加入编辑器扫描排除项（Zed `file_scan_exclusions`，如 `"**/worktrees/**"`、`"**/.build/**"`），删除前关闭对应窗口。
- 目录名带任务 slug，便于与 `worktree list`、`lsof` 输出对应。
- 删除前先 `git status`；有未提交改动先问用户。

## 清理

- 合并后删除 worktree 和已合并分支；用 harness 工具或 `git worktree remove`，再 `git branch -d`。
- 删除报 `Directory not empty` 或目录自动恢复：先按「目录删不掉：进程占用」定位持有进程，不要反复删除。
- 未提交、未合并的 worktree 不自动删。
- 删除有未提交改动的 worktree 必须先问用户；不要默认 `--force`。
- 定期 `git worktree prune` 清理失效记录。

## 输出要求

一次工作区处理，至少说明：

1. 这是只读还是写任务，为什么这样选
2. 分支名、worktree 位置、owner
3. 合并顺序与策略
4. 检查/审查结果
5. 冲突、未决项和风险
6. worktree/分支清理状态；只读任务说明未创建工作区

## 反模式

- 把「单会话」「文档小改」「很快」当成不建 worktree 的理由。
- 在 `main` 上直接编辑任务文件。
- 讨论已经决定要写，却继续在主工作区改。
- 两个会话在同一个 worktree 写。
- 同一个分支强开多个 worktree 写。
- 把 worktree 当成分支合并工具。
- 长分支长期不同步，最后一次性解决大量冲突。
- 自动解决语义冲突，不跑检查就合并。
- 删 worktree 前不检查未提交改动。
- 把 worktree 建在编辑器扫描范围内，删不掉时反复 `rm -rf` 而不查进程占用。
- 把「目录删了又出现」当成 Git 记录损坏，直接重建 worktree。
- 把依赖、构建产物、日志、本机配置带进提交。

## 交接

| Skill | 关系 |
|---|---|
| `session-handoff` | 会话边界与工作记忆；本 skill 负责读写分流与工作区隔离 |
| `git-commit` | 单仓库提交与推送；本 skill 负责分支/worktree 生命周期 |
| `git-commit` | 单仓库/多仓库提交与推送 |
| `code-review` | 合并前检查 |
| `execution-loop` | 工作包执行；写任务先建 worktree |
| `delivery-stage` | 交付阶段入口；检查写任务已在独立 worktree |
| `review` | 设计/方案决策 |
