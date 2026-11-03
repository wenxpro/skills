# Skills

个人 agent skills 仓库。每个 skill 是独立目录，含 `SKILL.md`（入口）及可选的引用文件（规范、模板等）。

## Skill 索引

- **game-docs** — 游戏项目文档体系：Run Brief、Design Spec、验收矩阵、ADR、6 人评审、试玩记录
- **docs-audit** — 文档集审核：交叉引用、翻译腔、版本锚点、图表覆盖、重复与数字核对
- **git-commit** — Git 提交：分析变更、按 Conventional Commits 生成 message、执行提交
- **topic-research** — 课题调研：生态全景、多入口交叉验证、证据分级，支撑外部结论写进文档
- **code-digest** — 代码库梳理：演进时间线 + 技术细节，防遗漏防过时、编号决策核对
- **roadmap-planning** — 演进规划：把设计结论按依赖链归入 MVP/V1/V2（或 M0/M1/M2），定优先级与落点
- **implementation-track** — 实现跟踪：验收项状态（◻/🔄/✅/❌）与偏差记录回写

## Skill 关系

```text
game-docs ──产出 01/02/03/05/06──▶ roadmap-planning ──分期──▶ implementation-track
    │                                   ▲                         │
    │                                   └────── 05/06 证据 ───────┘
    ├──▶ docs-audit（文档集审核）
    ├──▶ code-digest（代码现状输入）
    └──▶ topic-research（外部调研输入）
```

| 问题 | 用哪个 |
|---|---|
| 当前里程碑做什么、行为规则、怎么验收 | **game-docs** |
| 文档集有没有矛盾、过时、重复 | **docs-audit** |
| 哪些进 MVP / V1 / V2，先做哪个 | **roadmap-planning** |
| 验收项做到哪了、偏差怎么记 | **implementation-track** |
| 代码现在是什么样 | **code-digest** |
| 外部生态 / 竞品 / 技术选型 | **topic-research** |

## 共用约定

所有 skill 使用同一套语义，避免同名不同义：

| 约定 | 规则 |
|---|---|
| 文档 profile | `game-docs` 00~07 用 **game**；PRD + 各包 DESIGN.md 用 **software** |
| P0 / P1 | 只表示**验收优先级**：P0 阻断，P1 可后置 |
| 功能 / 包优先级 | `High / Medium / Low`，不要写成 P0/P1 |
| 状态标记 | `◻ 未开始 / 🔄 进行中 / ✅ 通过 / ❌ 失败` |
| 验收 ID | `AC-<类别>-<序号>`；跟踪 skill 直接引用，不另起编号 |
| 单一事实源 | 行为在 Spec，验收在 Acceptance，证据在 Review/Playtest；规划只排期，跟踪只更新状态 |

## 安装

把 skill 目录复制到对应位置，支持 `.agents/skills` 的 agent 会自动发现：

**全局（所有项目可用）**

```sh
mkdir -p ~/.agents/skills
cp -r game-docs ~/.agents/skills/
```

**项目级（随仓库共享给协作者）**

```sh
mkdir -p <project>/.agents/skills
cp -r game-docs <project>/.agents/skills/
```

更新：重新执行复制命令覆盖即可；卸载：删除对应目录。

> `game-docs` 的脚手架 / 检查脚本是 Windows PowerShell；非 Windows 可手动复制 `references/templates/`，或使用 PowerShell 7。

装完在新会话中按 skill 的触发场景试探一句，确认能被自动加载。

## 新增/维护 skill

- 每个 skill 一个目录，目录名即 skill 名（小写字母数字、单连字符分隔）
- 目录内必须有 `SKILL.md`，以 YAML frontmatter 开头，`name` 必须与目录名一致，`description` 写清触发场景（何时用、何时不用）
- 若设置 `disable-model-invocation: true`，agent 不会自动加载该 skill，只能通过 `/` 命令菜单手动调用
- 个人/团队偏好（风格、术语、环境约定）放引用文件，`SKILL.md` 中只保留通用流程：这样其他团队/项目只需整体替换 `standards.md`，通用流程无需改动
- 引用文件用相对路径，如 `standards.md`、`templates/foo.md`
- 不要写死本机绝对路径；示例用 `<target>`、`<project>`
