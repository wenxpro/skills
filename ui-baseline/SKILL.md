---
name: ui-baseline
description: 前端/UI 设计基线：语义 token、组件状态、屏幕规格、平台规范、无障碍与评审检查表。适用于新屏幕/组件/平台、UI 一致性评审、设计系统缺失；不适用于品牌视觉/插画、产品表面与导航（experience-architecture）、代码模块边界（responsibility-design）、代码审查（code-review）、软件文档槽位（software-docs）。
---

# UI Baseline

为前端/UI 建立可设计、可实现、可评审、可验收的基线。本 skill 负责 UI 这一垂直切片：设计规范、评审检查表、验收类别。

## 何时使用

- 新屏幕、新组件、新平台
- UI 不一致、缺设计系统、缺视觉/交互规范
- 需要做 UI 设计评审或实现前检查
- 需要给 UI 定义验收项与截图证据

不适用：

- 品牌视觉、插画、摄影素材、图标包 → 项目内容
- 产品表面、导航、状态所有权 → `experience-architecture`
- 代码模块/依赖边界 → `responsibility-design`
- 代码审查与合并前检查 → `code-review`
- 软件文档槽位与模板 → `software-docs`
- 单个页面的排版问答

## 核心规则

1. **Token 先行。** 颜色、字体、间距、圆角、动效走语义 token；View 不写死具体值。
2. **一屏一个主动作。** 主操作在拇指区，次操作不抢主色。
3. **状态完整。** 空、加载、错误、成功、禁用、按下都有定义；没有「默认状态之外靠临场发挥」。
4. **平台约定优先。** 系统导航、返回手势、Sheet、权限弹窗先按平台规范；不自造一套。
5. **无障碍默认开启。** 触控尺寸、对比度、Dynamic Type/缩放、屏幕阅读器、减少动态效果是基线，不是后补项。
6. **文案具体。** 不夸张、不暗示自动化；错误文案说明原因和下一步。
7. **截图是证据。** 评审和验收必须附浅色/深色、关键状态、关键尺寸的截图。

## 主动行为

本 skill 为参考型，不主动打断或提示；用户请求 UI 设计/评审时按流程执行。信息不足时先问平台、范围与品牌约束，不猜。

## 工作顺序

1. **选平台**：iOS → `references/ios.md`；Web → `references/web.md`。
2. **定 token**：颜色、字体层级、间距、圆角、网格、动效。
3. **定组件**：清单、变体、状态、无障碍标签、预览。
4. **定屏幕**：布局、主动作、返回、空/加载/错误、键盘/安全区。
5. **过平台与无障碍**：触控、对比度、动态字号、屏幕阅读器、减少动态效果。
6. **评审**：用 `references/review-checklist.md`；结论写进 `docs/09-reviews/`。
7. **验收**：`AC-UI-*`、`AC-A11Y-*`；证据放截图与测试记录。

## 产物

- `docs/UI-SPEC.md` — 本项目 UI 基线；模板见 `templates/ui-spec.md`
- 实现层 tokens 与组件 — 落到项目的 DesignSystem 目录
- 组件画廊或预览 — 覆盖 default / pressed / disabled / loading / error
- 评审截图 — 浅色/深色、关键状态、关键尺寸
- 验收项 — 引用 `docs-core/references/acceptance-taxonomy.md`

## 与其他 skill 的边界

| 问题 | 用 |
|---|---|
| 有哪些屏幕、怎么返回、状态归谁 | `experience-architecture` |
| 代码模块、依赖、状态边界 | `responsibility-design` |
| UI 设计规范、组件、HIG、无障碍 | 本 skill |
| 文档槽位、PRD/架构/验收文件 | `software-docs` |
| UI 代码实现与合并前检查 | `code-review` |
| 设计评审的角色与结论 | `review` |

## 反模式

- 没有 token，直接在每个 View 写颜色/字号/间距
- 只有正常状态，没有空/加载/错误/禁用
- 主次按钮同级，屏幕没有唯一主动作
- 44pt/触控尺寸、对比度、动态字号最后才看
- 只用颜色表达状态
- 截图只截浅色正常态，不截深色/大字号/错误
- 把 UI 规范和产品导航混在一份文档里
- 先写页面再补规范，导致组件各写一套

## 交接

- 设计阶段：`design-stage`
- 体验架构：`experience-architecture`
- 文档槽位：`software-docs`
- 评审：`review`
- 实现：`delivery-stage`
- 代码审查：`code-review`
- 验收跟踪：`implementation-track`
