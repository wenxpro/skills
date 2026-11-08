# 跨项目集成计划

> 用于两个以上仓库/团队共同交付一项能力。接口细节放 `interface-register.md`，依赖图放 `dependency-matrix.md`。

## 1. 能力与范围

| 项 | 内容 |
|---|---|
| 能力 / 功能 | `<capability>` |
| 涉及项目 | `<projects>` |
| 集成 owner | `<owner>` |
| 目标日期 | `<date>` |
| 明确不做 | `<non-goals>` |

## 2. 工作流

| 工作流 | Owner | 写集 | 读集 | 依赖 | 冻结点 | 合并顺序 | 验证 |
|---|---|---|---|---|---|---|---|
| `<workstream>` | `<owner>` | `<paths>` | `<paths>` | `<deps>` | `<date>` | `<order>` | `<command>` |

规则：

- 写集重叠的工作流不能同时写。
- 共享文件/资源必须有单一写者或冻结窗口。
- 先完成上游接口，再做下游适配，最后做端到端。

## 3. 共享文件 / 资源

| 文件 / 资源 | Owner | 当前写者 | 冻结窗口 | 冲突处理 |
|---|---|---|---|---|
| `<path>` | `<owner>` | `<writer>` | `<window>` | `<merge/rollback>` |

## 4. 集成检查

| 检查 | 层 | 命令 / 样本 | 期望 | 证据位置 |
|---|---|---|---|---|
| `<check>` | 生产者 | `<command>` | `<expected>` | `<path>` |
| `<check>` | 消费者 | `<command>` | `<expected>` | `<path>` |
| `<check>` | 端到端 | `<command>` | `<expected>` | `<path>` |

## 5. 切换与回滚

| 项 | 内容 |
|---|---|
| 切换方式 | 新旧并行 / feature flag / 灰度 |
| 默认路径切换条件 | parity 通过 + 证据齐全 + owner 确认 |
| 回滚条件 | `<condition>` |
| 回滚命令 / 步骤 | `<steps>` |

## 6. 交接与未决问题

| # | 问题 / 交接项 | Owner | 下一步 | 截止 |
|---|---|---|---|---|
| 1 | `<item>` | `<owner>` | `<next>` | `<date>` |

## 7. 收口记录

| 日期 | 版本 | 完成项 | 未完成项 | 后续动作 |
|---|---|---|---|---|
| `<date>` | `<version>` | `<done>` | `<open>` | `<next>` |
