---
name: game-docs
description: 建立、维护游戏项目文档体系：Run Brief、Design Spec、验收矩阵、ADR、试玩记录。适用于新游戏立项、写/重构 GDD 或行为规范、定义验收标准、记录试玩；评审使用 review skill 的 game profile。不适用于纯代码修复、已有文档集的交叉引用审核（用 docs-audit）、跨版本规划（用 roadmap-planning）或实现状态跟踪（用 implementation-track）。Game docs / GDD / spec / acceptance / playtest.
---

# Game Docs

A documentation system for game projects. It makes design decisions explicit, testable, and reviewable.

It does **not** invent the game for the user. It asks the questions, provides the structure, and enforces the change process.

## When to use

- Starting a new game project and need a Run Brief / GDD / spec
- Refactoring an existing design document into a testable form
- Defining acceptance criteria or a QA matrix
- Running a design review (use the `review` skill with the game profile)
- Recording and analyzing playtests
- Changing existing behavior without letting the spec drift

## When not to use

- A pure code bugfix with no design change
- A one-off game design question that can be answered directly
- The user only wants code, not documentation
- The project is past the current milestone and the user wants to write future content (write it later)

## Core rules

1. **Discovery is one page; contract is long.** Before the loop is proven, keep the Run Brief short. Once behavior must be built and accepted, write the precise Design Spec.
2. **Only document the current milestone.** Never pre-write 8-minute modes, bosses, or extra characters while the current loop is unproven.
3. **Behavior change = Spec + Acceptance + Changelog.** Never change only one of the three.
4. **Every P0 rule has an acceptance case.** If it cannot be tested, it is not a rule.
5. **Review at every milestone.** Use the `review` skill with `profiles/game.md`; game-specific roles live there.
6. **Never copy another project's content.** Templates are structure; content is project-specific.
7. **Write into the target project's `docs/`, never into this skill directory.**

## Workflow router

Read only the workflow needed for the current request. Do not load all references at once.

| User intent | Read |
|---|---|
| Start docs for a new project / refactor docs | `references/workflows/01-init.md` |
| Write or refresh the Design Spec | `references/workflows/02-spec.md` |
| Define or update acceptance criteria | `references/workflows/03-acceptance.md` |
| Run a review | `review` skill: `profiles/game.md` + `references/workflow.md` |
| Run or record a playtest | `references/workflows/05-playtest.md` |
| Change existing behavior/docs | `references/workflows/06-maintain.md` |

## Resources

- `standards.md` — 个人/团队偏好：文档语言、P0/P1、脚本环境；评审流程见 `review` skill
- `references/templates/` — 00~07 文档模板
- `references/templates/00-README.md` — numbering, statuses, change flow; review 指向 `review` skill
- `references/examples.md` — reference implementation (do not copy its content)
- `scripts/new-project-docs.ps1` — scaffold a docs folder
- `scripts/check-docs.ps1` — check required files, numbering, links, placeholders

## Related skills

| Skill | 关系 |
|---|---|
| `review` | 通用评审流程；游戏使用 `profiles/game.md` |
| `docs-audit` | 文档集深度审核；可在评审前作为可选自检 |
| `roadmap-planning` | 当前里程碑通过后，规划 MVP / V1 / V2 |
| `implementation-track` | Spec / Acceptance 确定后，跟踪实现与验收状态 |
| `code-digest` | 需要把代码现状写进设计文档时，作为输入 |
| `topic-research` | 需要外部生态 / 竞品结论时，作为输入 |

> 不要重复实现 `docs-audit` 的审核清单；`game-docs` 只负责创建和维护当前里程碑的文档。

## Cross-skill contract

所有 skill 共用同一套约定：

| 约定 | 规则 |
|---|---|
| P0/P1 | 只表示**验收优先级**；功能/包优先级用 `High / Medium / Low` |
| 状态标记 | `◻ 未开始 / 🔄 进行中 / ✅ 通过 / ❌ 失败` |
| 里程碑 | game profile 用 `M0 / M1 / M2`；软件 profile 可用 `MVP / V1 / V2` |
| 验收 ID | `AC-<类别>-<序号>`；`implementation-track` 直接引用，不另起编号 |
| 单一事实源 | `02` 定行为、`03` 定验收、`05/06` 记证据；`roadmap-planning` 只排期，不重写规则 |
| 交接 | 本 skill 产出 `01/02/03/05/06`；`roadmap-planning` 读取后排期；`implementation-track` 读取 `03` 跟踪状态 |

## Scripts

Run from the skill root:

```powershell
.\scripts\new-project-docs.ps1 `
  -Target "<target>" `
  -ProjectName "My Game" `
  -Genre "Roguelite" `
  -CoreVerb "move + auto attack" `
  -Milestone "M0 立项"
```

```powershell
.\scripts\check-docs.ps1 -DocsPath "<target>\docs"
```

If the skill is installed globally, path the scripts through the installed skill directory. Do not assume the current working directory is the skill root.

## Guardrails

- **Ask before overwriting** an existing `docs/` folder. Never use `-Force` without explicit permission.
- **Do not guess** project name, genre, core verb, or milestone. Ask.
- **Do not fill 02/03 before 01 is accepted.** The one-pager drives the spec.
- **Do not write future milestone content.** Put it in "Open questions" or a later milestone.
- **Do not put project content into the skill.** The skill is read-only; the target project owns its docs.
- **Always run `check-docs.ps1`** after structural changes and report the result.
- **Do not split this skill into one skill per workflow** unless a workflow is used independently across projects. The shared templates and conventions are the point.

## Output contract

After each workflow, report:

1. Files created or changed
2. `check-docs.ps1` result
3. Open questions / decisions needed
4. Next recommended workflow
