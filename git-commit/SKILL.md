---
name: git-commit
description: Git 提交（单仓库）：按 Conventional Commits 生成 message，直接提交推送（设计确认后属执行阶段）。适用于完成功能/修复/重构/文档后的提交；不适用于多仓库提交（multi-repo-commit）、设计决策、文档内容审核（docs-audit）、改写历史（先问）。
---

# Git 提交

按下面的流程处理一次提交。目标：每次提交一件事，message 可读、可检索、可追溯。

## 何时使用

- 用户要求提交（「提交一下」「commit 这些改动」）
- 功能、修复、重构、文档等阶段性完成后需要落一次提交

不适用：方案尚未确认的执行（先做设计）、文档内容审核（用 `docs-audit`，需要改写历史或强制推送时先问用户）。

## 操作流程

1. **看变更**：`git status` 看文件清单，`git diff`（未暂存）和 `git diff --cached`（已暂存）看内容
2. **分类**：按变更性质归类，一个提交只做一件事；默认按性质拆成多个提交，汇报时说明
3. **检查无关文件**：`.DS_Store`、构建产物、依赖目录、日志等不应进仓库，自动排除并告知（必要时更新 .gitignore），不因此中断；用户的未提交工作不碰
4. **生成 message**：按 `standards.md` 的格式生成
5. **执行提交与推送**：`git add` + `GIT_EDITOR=true git commit -m "<message>"`，随后 `git push`（按项目远程配置）

## 边界

- 设计 / 方案确认后，提交与推送属于执行动作，直接做到目标，不逐次询问
- 仅在 message 有歧义、变更混入用户未提交的工作、或需要不可逆操作（force push、删分支）时询问
- 提交失败（pre-commit 钩子、lint 失败等）时报告错误，不擅自绕过
- 写任务默认在独立 worktree 内完成；分支/worktree 的创建、合并、清理见 `worktree-workflow`；本 skill 只负责单仓库提交与推送
- 一次任务涉及多个独立仓库时，用 `multi-repo-commit` 逐仓库编排
- 提交后需要跨会话交接时，用 `session-handoff`；提交是 handoff 的事实源之一

## 交接

- 交付阶段：由 `delivery-stage` 组织
- 提交前置：`code-review` 通过；写任务已在独立 worktree 内完成
- 工作区/读写分流：`worktree-workflow`
- 多仓库提交：`multi-repo-commit`
- 验收状态：`implementation-track`
- 反馈：交付结果交 `feedback-stage`
