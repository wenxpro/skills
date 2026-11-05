---
name: git-commit
description: 为工作区变更生成规范的 git 提交信息并直接提交推送。分析未提交变更（git status/diff），按性质分类，生成 Conventional Commits 格式的 message（规范见 standards.md），排除无关文件后执行 git add、git commit 与推送。设计/方案确认后属于执行阶段，不逐次确认。适用于完成功能、修复、重构、文档等需要提交时。
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
