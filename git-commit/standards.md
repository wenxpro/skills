# Git 提交规范（Conventional Commits）

本文件是 `git-commit` 的提交信息规范，其他团队可整体替换为本团队标准。

## 提交与推送策略

- 设计/方案确认后，git 提交与推送属于执行阶段：直接提交、直接推送，不逐次确认。
- 提交前自查：message 合规、无无关文件、变更范围与 message 一致。
- 多类变更默认拆成多个提交，汇报时说明拆分理由。
- 推送失败作为阻塞上报（认证、网络、冲突），不反复重试超过 3 次。
- 只有不可逆操作（force push、删分支、改写历史）必须先问。

## 格式

```
<type>(<scope>): <subject>
```

- **type**：必填，见下表
- **scope**：可选，影响的模块/范围，如 `docs-audit`、`README`
- **subject**：必填，一句话概括，不带结尾句号

## type 取值

| type    | 用途               |
| ------- | ------------------ |
| feat    | 新功能             |
| fix     | 修复 bug           |
| docs    | 仅文档             |
| style   | 格式调整，不影响逻辑 |
| refactor| 重构，不改行为     |
| perf    | 性能优化           |
| test    | 测试相关           |
| build   | 构建系统或依赖     |
| ci      | CI 配置            |
| chore   | 杂项（.gitignore 等） |
| revert  | 回滚               |

## 规则

- subject 用中文，简洁具体，一眼能看出做了什么，如 `docs: 修正 README 安装命令路径`
- 破坏性变更在 type 后加 `!`（如 `feat!:`），并在提交正文注明 BREAKING CHANGE 及影响
- 一次提交一件事；内容混杂时拆成多个提交
- message 只描述本次变更，不夹带其他改动
