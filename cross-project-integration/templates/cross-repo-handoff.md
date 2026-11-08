# 跨项目交接

> 一页工作记忆；只写会影响下一步的内容。长期事实链接到接口登记表、项目文档、提交和证据。

## 0. 边界

| 项目 / 仓库 | 分支 | HEAD | 工作区 | 接口版本 |
|---|---|---|---|---|
| `<repo-a>` | `<branch>` | `<hash>` | clean / dirty | `v1.0` |
| `<repo-b>` | `<branch>` | `<hash>` | clean / dirty | `v1.0` |

## 1. 目标 / 完成标准

- 目标：`<goal>`
- 完成标准：`<definition-of-done>`
- 明确不做：`<non-goals>`

## 2. 当前状态

| 项 | 内容 |
|---|---|
| 已完成 | `<done>` |
| 进行中 | `<in-progress>` |
| 未开始 | `<todo>` |
| 当前阻塞 | `<blocker>` |

## 3. 接口状态

| 接口 | 版本 | 状态 | 生产者检查 | 消费者检查 | 证据 |
|---|---|---|---|---|---|
| `<interface>` | `v1.0` | 草案 / 冻结 / 迁移中 | `<result>` | `<result>` | `<path>` |

## 4. 验证证据

- 命令：`<command>`
- 样本 / seed：`<sample>`
- 输出 / 报告：`<path>`
- 差异说明：`<notes>`

## 5. 下一步第一条命令

```text
<command>
```

## 6. 约束 / 不要动

- `<constraint>`
- `<shared-file-freeze>`
- `<old-path-retention>`

## 7. 未决问题 / Owner

| # | 问题 | Owner | 下一步 | 截止 |
|---|---|---|---|---|
| 1 | `<question>` | `<owner>` | `<next>` | `<date>` |
