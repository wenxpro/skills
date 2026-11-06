---
name: stage-router
description: 项目阶段路由：判断当前处于设计、交付还是反馈，给出入口条件、推荐 skill、出口与回流路径。适用于跨阶段组织、新项目/新功能从设计到交付到反馈、不知道该用哪个 skill 时；不适用于单点设计方法、代码审查、文档审核、验收跟踪本身。
---

# 项目阶段路由

目标：用一个 skill 管住「设计 → 交付 → 反馈」的生命周期入口，而不是为每个阶段各建一个薄路由。

本 skill 只做**阶段判断、入口检查、skill 路由与回流**；具体方法由各专业 skill 执行。不要把方法细节复制进来。

## 何时使用

- 新项目、新功能、新模块，先判断该进入设计、交付还是反馈
- 跨阶段工作：设计确认后怎么交付、交付完成后怎么回流
- 不知道该用哪个 skill，需要一个入口
- 评审/试玩/测试结果出来后，判断下一步是修、重设计还是排下一期
- 需要检查阶段入口条件是否满足

不适用：

- 单点设计方法 → `experience-architecture` / `responsibility-design` / `game-docs` / `docs-core`
- 代码审查 → `code-review`
- 文档集审核 → `docs-audit`
- 验收状态与偏差记录 → `implementation-track`
- 单点问答，不需要阶段路由

## 阶段表

| 阶段 | 核心问题 | 入口 | 主要 skill | 出口 |
|---|---|---|---|---|
| **设计** | 做什么、边界在哪、谁拥有什么、怎么验收 | 目标/输入/约束清楚 | `experience-architecture` / `responsibility-design` / `game-docs` / `docs-core` | `review` → `roadmap-planning` |
| **交付** | 怎么实现、怎么检查、怎么提交 | 设计/评审/规划已确认；验收项明确 | `execution-loop` / `code-review` / `git-commit` / `implementation-track` | 可提交/可合并；状态已更新 |
| **反馈** | 结果说明什么、下一步去哪 | 有测试/试玩/审查/文档证据 | `implementation-track` / `docs-audit` / `review` / `roadmap-planning` | 回流设计、规划或修复 |

## 设计阶段

入口检查：

- 设计问题、范围、约束、决策人清楚
- 必要输入已选：`topic-research` / `code-digest` / `docs-audit` / `implementation-track`
- 不把实现问题当设计问题

路由：

```text
输入
  → experience-architecture（产品表面/导航/状态所有权）
  → responsibility-design（模块/所有权/依赖方向）
  → game-docs / docs-core（行为规则/验收/ADR）
  → review
  → roadmap-planning
```

规则：

- 职责设计是设计阶段能力，不是代码梳理后的修正；现有代码问题才走 `code-digest → responsibility-design`。
- 体验架构与职责设计可以并行，但要有交接：产品状态边界 → 代码模块边界。
- 方向/架构/体验变化必须过 `review`；不要用实现绕过。
- 设计阶段输出验收种子与实现工作包，交给规划/交付。

## 交付阶段

入口检查：

- 设计/方案已确认，或已有明确验收项
- 工作包范围、完成标准、约束、依赖清楚
- 需要跑的检查/测试已列出
- 回滚或失败处理已明确（如适用）

路由：

```text
roadmap-planning
  → execution-loop
  → code-review
  → git-commit
  → implementation-track
```

规则：

- 每个可合并单元走 `code-review`；高风险改动不能跳过。
- 提交走 `git-commit`；不跳过检查直接提交。
- 验收状态由 `implementation-track` 更新；没有证据不算通过。
- 发现设计/范围冲突，回设计阶段或 `review`，不要用实现掩盖。

## 反馈阶段

入口检查：

- 有可复核的证据：测试、试玩、审查、文档审计、验收状态
- 能区分事实、判断和推断
- 知道反馈对象：设计、规划还是修复

路由：

```text
execution-loop / code-review
  → implementation-track
  → docs-audit / review / roadmap-planning / 设计阶段
```

规则：

- 证据保留日期、版本、样本、命令；历史证据不追改。
- 文档漂移交 `docs-audit` / `docs-core`。
- 设计/范围变化交 `review` / 设计阶段，不借反馈直接改规则。
- 版本/优先级变化交 `roadmap-planning`。
- 失败、跳过、样本不足都算反馈，不隐藏。

## 输出要求

阶段路由结束至少说明：

1. 当前阶段与判断依据
2. 入口条件是否满足
3. 推荐 skill 与执行顺序
4. 出口条件
5. 未满足项与下一步
6. 需要回流的设计/规划/修复事项

## 边界与反模式

- 不替代具体方法：本 skill 只做路由，不写体验架构/职责设计/文档规则/代码审查细节。
- 不为每个阶段各建一个薄路由；阶段是同一个生命周期的不同段，统一在这里判断。
- 不把生命周期当瀑布：设计、交付、反馈可以迭代回流。
- 不跳过评审、代码审查或反馈；没有证据不算通过。
- 不把项目专有词、数值、版本写进本 skill；放项目文档。
- 不把「阶段判断」变成状态会议；只输出路由和下一步。

## 交接

| Skill | 关系 |
|---|---|
| `experience-architecture` | 设计：产品表面、导航、状态所有权 |
| `responsibility-design` | 设计/重构：模块边界、所有权、依赖方向 |
| `game-docs` / `docs-core` | 设计：行为规则、验收、ADR、文档槽位 |
| `topic-research` / `code-digest` / `docs-audit` / `implementation-track` | 设计/反馈输入 |
| `review` | 设计/方案/体验/架构评审 |
| `roadmap-planning` | 规划与分期 |
| `execution-loop` | 交付：连续执行 |
| `code-review` | 交付：合并前检查 |
| `git-commit` | 交付：提交与推送 |
| `implementation-track` | 交付/反馈：验收状态与偏差 |
