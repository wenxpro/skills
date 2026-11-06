# 并行工作树偏好

本文件存放 `parallel-worktree` 中依赖个人/团队习惯的部分，可整体替换；`SKILL.md` 不依赖具体命名。

## 分支命名

- `feat/<slug>`：功能
- `fix/<slug>`：修复
- `docs/<slug>`：文档
- `exp/<slug>`：实验/方案对比
- `review/<slug>`：评审或只读对比

规则：

- slug 用小写连字符，例如 `audio-mixer`、`hud-split`
- 一个分支只做一件事
- 不把日期、人名、版本号写进 slug；需要追溯时放提交或 handoff

## worktree 位置

- 优先使用 agent/harness 管理的 worktree 目录
- 手动创建时放在仓库同级目录，例如 `<repo>-wt-<slug>`
- 不放在仓库内部，除非该目录已在 `.gitignore` 中
- 一个 worktree 只对应一个分支

## 合并策略

默认：

- 主工作区始终留在 `main`
- 单分支按顺序 `merge --no-ff` 回 `main`
- 同批多分支先进 `integration/<topic>`，整体检查后再回 `main`
- 合并后主工作区复跑检查

可选：

- 单人追求线性历史：特性分支 rebase `main` 后 fast-forward
- 需要评审：push 分支，走 PR/MR
- 需要保留分支粒度：`merge --no-ff`
- 需要单提交：squash merge

禁止：

- rebase 共享 `main`
- force push 共享分支
- 未跑检查直接合并
- 自动解决语义冲突

## 清理

- 合并后移除 worktree，再删除已合并分支
- 未提交/未合并的 worktree 保留
- `--force` 删除前必须确认
- 定期 `git worktree prune`

## 并行 owner

- 共享接口、配置、内容表、生成脚本指定唯一 owner
- 一个 worktree 一个写者
- 只读会话可以共享主工作区
- 写会话之间用分支/worktree 隔离，不用聊天同步文件
