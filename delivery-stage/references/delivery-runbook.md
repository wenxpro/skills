# 交付 runbook

> 只写顺序、输入输出和交接点；具体规则仍由各 skill 负责。

## 1. 入口确认

1. 验收项、工作包范围与完成标准。
2. 依赖与前置项已完成。
3. 需要跑的检查/测试已列出。
4. 写任务已进入独立 worktree。
5. 回滚或失败处理明确。
6. 跨项目/跨仓库时，接口登记表、集成计划与合并顺序已确认。

任一不满足：回 `design-stage` / `review` / `roadmap-planning`，不用实现掩盖设计问题。

## 2. 拆工作包

- 每个工作包能独立验证。
- 写集尽量不重叠；共享文件指定单一写者或冻结窗口。
- 跨项目工作包先完成上游接口，再做下游适配，最后端到端。

## 3. 单仓库内循环

```text
worktree-workflow → execution-loop → code-review → git-commit → implementation-track
```

- `worktree-workflow`：隔离写任务。
- `execution-loop`：连续执行、自测，只在真实阻塞时停。
- `code-review`：合并前检查。
- `git-commit`：按 Conventional Commits 提交与推送。
- `implementation-track`：更新验收状态与偏差。

## 4. 多仓库循环

```text
cross-project-integration → 每个仓库 worktree-workflow
→ execution-loop → code-review → git-commit（多仓库模式）
→ session-handoff
```

- 先确认接口版本与合并顺序。
- 每个仓库独立提交、独立推送、独立验证。
- 部分失败只重试失败仓库；不要声称全部完成。

## 5. 停止条件

- 发现设计、范围、优先级冲突。
- 缺少证据却要写“通过”。
- 共享文件冲突，且没有单一写者。
- 跨项目接口版本不一致，或下游会失效。
- 测试失败且原因不明。

## 6. 出口

至少报告：

1. 工作包范围与验收项。
2. 实际改动、检查/测试结果与证据。
3. 代码审查结论与提交记录。
4. 验收状态、未关闭项与需回流事项。
5. 跨项目时：接口版本、各仓库 HEAD、集成检查结果。
