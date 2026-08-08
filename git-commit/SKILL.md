---
name: git-commit
description: 为工作区变更生成规范的 git 提交信息并执行提交。分析未提交变更（git status/diff），按性质分类，生成 Conventional Commits 格式的 message（规范见 standards.md），检查并排除无关文件后执行 git add 与 git commit。适用于完成功能、修复、重构、文档等需要提交时。
---

# Git 提交

按下面的流程处理一次提交。目标：每次提交一件事，message 可读、可检索、可追溯。

## 何时使用

- 用户要求提交（「提交一下」「commit 这些改动」）
- 功能、修复、重构、文档等阶段性完成后需要落一次提交

## 操作流程

1. **看变更**：`git status` 看文件清单，`git diff`（未暂存）和 `git diff --cached`（已暂存）看内容
2. **分类**：按变更性质归类，一个提交只做一件事；涉及多类变更时先提醒用户是否分开提交
3. **检查无关文件**：`.DS_Store`、构建产物、依赖目录、日志等不应进仓库，提醒排除（必要时更新 .gitignore），不擅自删除或提交
4. **生成 message**：按 `standards.md` 的格式生成，提交前展示给用户确认
5. **执行提交**：用户确认后执行 `git add` + `GIT_EDITOR=true git commit -m "<message>"`

## 边界

- 默认不 push，用户要求时才推送
- 不提交用户未确认的文件；拿不准的变更先问用户
- 提交失败（pre-commit 钩子、lint 失败等）时报告错误，不擅自绕过
