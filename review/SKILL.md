---
name: review
description: 通用多角色评审：决策问题、角色意见、条件与行动项、证据、active/archive 索引。适用于里程碑/方案/体验架构/文档/架构评审与 ADR 决策；不适用于文档集审核（docs-audit）、规划（roadmap-planning）、实现跟踪（implementation-track）。Review / design review.
---

# Review

A reusable review workflow. It turns a proposal into a **decision record** with roles, conditions, actions, evidence, and a clear outcome.

It does **not** invent decisions. It forces the right questions and makes the outcome traceable.

## When to use

- 里程碑评审：Spec + Acceptance 完成，准备进入实现或下一阶段
- 方案评审：架构、数据、接口、上线方案
- 体验架构评审：屏幕、导航、状态所有权、暂停/结算/重试流程（用 `profiles/experience.md`）
- 文档评审：文档体系、规范、ADR 提案
- 有争议的方向，需要多视角压力测试

## When not to use

- 纯代码修复，没有设计/行为变化
- 代码审查 / 合并前检查 → `code-review`
- 只需要一个简短的设计问答
- 文档集交叉引用审核 → `docs-audit`
- 跨版本排期 → `roadmap-planning`
- 验收状态跟踪 → `implementation-track`

## Core rules

1. **一个评审只回答一个决策问题。** 不把多个无关议题塞进一份记录。
2. **角色来自 profile。** 游戏、软件、文档、架构的角色不同，不要把一个 profile 的角色集复制到所有领域。
3. **每个角色必须给出：通过 / 有条件通过 / 否决 + 理由。** 「大家觉得不错」不是结论。
4. **条件必须可执行。** 每条条件有 ID、负责人、写入位置、截止时间。
5. **证据优先。** Spec、验收、ADR、测试、试用/用户测试、监控数据；没有证据就不算通过。
6. **当前有效 vs 历史归档分开。** 废案、被取代的方案移出 active 评审，不留在当前约束里。
7. **评审记录 1~2 页。** 角色意见用表格，不写长篇独白。
8. **不替用户拍板。** 评审可以建议，最终结论由决策人确认。
9. **设计提案先缓冲。** 评审中提出的新方向、范围变化、取舍先留在评审/待决列表，不直接写进规则文档或 ADR；负责人确认后再落文档。

## Workflow router

| User intent | Read |
|---|---|
| 跑一次完整评审 | `references/workflow.md` |
| 选择角色与否决规则 | `profiles/<profile>.md` |
| 写评审记录 | `templates/review.md` |
| 维护 active / archive 索引 | `templates/review-index.md` |
| 检查评审记录完整性 | `scripts/check-review.ps1` |

## Profiles

| Profile | 适用 | 角色 |
|---|---|---|
| `game` | 游戏设计、玩法、里程碑 | 目标玩家、游戏设计师、技术负责人、美术/UX、制作人、QA |
| `software` | 软件产品、API、平台 | 用户/客户、产品、技术负责人、UX、PM、QA/安全 |
| `docs` | 文档体系、规范、教程 | 目标读者、领域专家、技术写作、维护者、PM、QA |
| `architecture` | 架构、基础设施、上线 | 业务负责人、架构师、安全、运维、开发、QA |
| `experience` | 产品表面、导航、App Shell | 新用户、回访用户、UX、技术负责人、QA |

没有合适 profile 时，先定义一个最小角色集，不要直接套其他领域的角色。

## Output contract

每次评审结束必须报告：

1. 评审文件路径
2. 结论：通过 / 有条件通过 / 否决
3. 未关闭条件与行动项
4. `check-review.ps1` 结果
5. 是否更新 active / archive 索引
6. 下一步（实现、补证据、重审）

## Related skills

| Skill | 关系 |
|---|---|
| `design-stage` / `delivery-stage` / `feedback-stage` | 阶段 playbook；评审是设计出口，结论转交付/反馈 |
| `game-docs` | 游戏文档体系；评审时使用 `profiles/game.md` |
| `experience-architecture` | 产品表面、导航、状态所有权；评审时使用 `profiles/experience.md` |
| `code-review` | 代码审查与合并前检查；本 skill 不审代码实现 |
| `docs-audit` | 评审前可选的文档集审核 |
| `roadmap-planning` | 评审通过后排期 |
| `implementation-track` | 评审后跟踪行动项与验收 |

## Guardrails

- **Ask before deleting review history.** 默认归档，不物理删除。
- **Do not mark pass without evidence.** 缺证据时结论只能是「有条件通过」或「待补证据」。
- **Do not keep obsolete proposals in active reviews.** 归档并在索引里标 `Superseded`。
- **Do not duplicate role definitions across skills.** 角色属于 profile，流程属于本 skill。
- **Do not write project content into this skill.** 记录写进目标项目。
- **Do not use review as a status meeting.** 没有决策问题就不开评审。
