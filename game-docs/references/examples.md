# 参考实现

本 skill 是从作者的一个本地 Roguelike 项目文档中抽取的。

参考实现不随本仓库分发；它只用于对照结构与写法，不是模板内容的一部分。

## 可以对照看什么

- 编号体系：00~07 的职责划分
- 填好的 Run Brief：一页纸如何收敛
- 填好的 Design Spec：规则 ID 如何写
- 填好的验收矩阵：P0/P1 如何映射
- 填好的 ADR：备选方案与否决理由
- 填好的 6 人评审：条件、签字、行动项

## 不要直接复制它的内容

参考实现的内容是针对「自动射击 Roguelite」的：

- 具体数值
- 具体状态
- 具体验收用例
- 具体评审意见
- 具体 ADR 结论

这些**不是模板的一部分**。模板只提供问题和结构，答案必须由你的项目自己填。

## 推荐用法

1. 先看 `references/templates/00-README.md`，理解编号和文档分工
2. 看 `references/templates/02-design-spec.md` 的规则 ID 写法
3. 看 `references/templates/05-reviews/0000-review-template.md` 的签字表
4. 回到自己的项目，从 `01-run-brief.md` 开始填，不要抄内容
