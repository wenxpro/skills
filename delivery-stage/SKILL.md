---
name: delivery-stage
description: 交付阶段 playbook：确认设计与规划入口，按工作包实现，过代码审查和改动检查后提交，并更新验收状态。适用于已确认方案的功能、修复、重构交付；不适用于设计决策、方案评审、需求变更、路线图规划、文档集审核。
---

# 交付阶段

目标：把已确认的设计变成可提交、可合并、可验收的改动。

## 入口

设计/评审/规划已确认后进入。开始前确认：

1. 验收项、工作包范围与完成标准清楚
2. 依赖与前置项已完成
3. 需要跑的检查/测试已列出
4. 写任务已进入独立 worktree；不在主工作区直接编辑
5. 回滚或失败处理明确（如适用）
6. 跨项目/跨仓库时，接口登记表、集成计划与合并顺序已确认

任一不满足：回 `design-stage` / `review` / `roadmap-planning`，不用实现掩盖设计问题。

不适用：设计决策 → `design-stage`；方案评审 → `review`；跨版本排期 → `roadmap-planning`；文档集审核 → `docs-audit`。

## 推进

按依赖顺序拆工作包，每个工作包能独立验证；连续执行交给 `execution-loop`，只在真实阻塞时停。

每个可合并单元：

1. `code-review` 审查改动与测试
2. 跑该改动类型要求的检查
3. 通过后 `git-commit` 提交
4. `implementation-track` 更新验收状态与偏差

## 检查矩阵

| 改动类型 | 必做检查 |
|---|---|
| 行为 / 规则 | 行为测试 + 规则与验收同步 + `code-review` |
| 配置 / 数值 | 配置校验 + 默认值 / 边界 + `code-review` |
| 状态 / 计时 / 随机 | 重开 / 恢复 / 随机复现一致性 + `code-review` |
| 测试本身 | 断言质量、失败路径、`code-review` |
| 文档 | `docs-core` 行为变更三件套；按需 `docs-audit` |
| 跨项目接口 | 生产者检查 + 消费者检查 + 集成计划 + 跨项目交接 |
| 每次提交 | `git-commit` |

具体命令、阈值、样本量放项目规范，不写进本 skill。

## 出口

交付结束至少报告：

1. 工作包范围与验收项
2. 实际改动、检查/测试结果与证据
3. 代码审查结论与提交记录
4. 验收状态、未关闭项与需回流事项

## 反模式

- 擅自改设计、范围、优先级；发现冲突回 `design-stage` / `review`。
- 跳过代码审查直接提交；删除失败测试或降低断言。
- 用测试全绿代替审查，或用审查代替测试。
- 没有证据就把验收写成通过。
- 把交付阶段变成状态会议。

## 交接

- 上一阶段：`design-stage` / `roadmap-planning`
- 下一阶段：`feedback-stage`
- 执行与检查：`execution-loop` → `code-review` → `git-commit` → `implementation-track`
- 会话切换/交接：`session-handoff`
- 工作区/读写分流（写任务默认 worktree）：`worktree-workflow`
- 多仓库提交：`multi-repo-commit`
- 跨项目接口与集成计划：`cross-project-integration`
