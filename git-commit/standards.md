# Git 提交规范（Conventional Commits）

本文件是 `git-commit` 的提交信息规范，其他团队可整体替换为本团队标准。

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
