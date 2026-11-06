# Skills

个人 agent skills 仓库。每个 skill 是独立目录，含 `SKILL.md`（入口）及可选的引用文件（规范、模板等）。

## Skill 索引

- **design-stage** — 设计阶段 playbook：输入选择 → 体验架构/职责设计/图设计（上下文/生命周期/时序）→ 文档规则 → 评审 → 规划；只写本阶段入口、检查与出口
- **delivery-stage** — 交付阶段 playbook：入口确认 → 工作包执行 → 代码审查与改动检查 → 提交 → 验收状态
- **feedback-stage** — 反馈阶段 playbook：证据收集与分类 → 状态/文档更新 → 评审/规划/设计回流
- **session-handoff** — 会话边界与外部记忆：继续/新开判断、一页 handoff、记忆分层、并行/模型切换；不替代 execution-loop
- **parallel-worktree** — 并行会话与 Git 工作树：独立 worktree + 短分支、合并顺序、冲突与清理；只做工作区隔离，不替代 git-commit/code-review
- **multi-repo-commit** — 单会话多仓库提交：按仓库分组、分别提交推送、记录部分失败与跨仓库一致性；不替代 git-commit/parallel-worktree
- **docs-core** — 通用文档体系规则：7 类文档（入口/假设/规则/验收/决策/证据/检查，可裁剪）、单一事实源、行为变更三件套、ADR 实施/归档、状态语义（不绑领域）
- **game-docs** — 游戏文档体系（基于 docs-core）：Run Brief、Design Spec、验收矩阵、ADR、试玩；含跨项目设计模式参考
- **experience-architecture** — 产品体验架构：一页 Experience Map、屏幕/导航、状态所有权、生命周期、入口/退出与延后项；新增表面前的触发门
- **review** — 通用多角色评审：决策问题、角色意见、条件与行动项、证据、active/archive 索引；设计提案先缓冲
- **code-review** — 代码审查与合并前检查：必须修/建议修/可选分级、改动类型 → 必跑检查、测试质量、修复复跑；含游戏/软件/服务检查清单
- **docs-audit** — 文档集审核：交叉引用、术语一致性、翻译腔、版本锚点、图表覆盖、重复与数字核对；含实现后漂移扫描与 ID 覆盖矩阵
- **git-commit** — Git 提交：分析变更、按 Conventional Commits 生成 message、执行提交
- **topic-research** — 课题调研：生态全景、多入口交叉验证、证据分级，支撑外部结论写进文档
- **code-digest** — 代码库梳理：演进时间线 + 技术细节，防遗漏防过时、编号决策核对
- **roadmap-planning** — 演进规划：把设计结论按依赖链归入 MVP/V1/V2（或 M0/M1/M2），定优先级与落点；含 M/W 两层映射
- **implementation-track** — 实现跟踪：验收项状态（◻/🔄/✅/❌）与偏差记录回写；含证据阶梯与最小 fake 接口
- **execution-loop** — 连续执行闭环：一次确认目标，批量执行、自测、提交、更新跟踪，只在真实阻塞时停
- **responsibility-design** — 职责驱动设计：上下文地图、所有权、依赖方向、生命周期所有权、边界违规、组合根拆分与行为保持重构
- **skill-audit** — Skill 仓库审核：抽象分层、结构与触发边界、主动行为/干预策略、术语一致性、交叉引用与职责重叠

## Skill 关系

```text
设计 design-stage
  输入   topic-research / code-digest / docs-audit / implementation-track
  方法   experience-architecture / responsibility-design / 图设计 / game-docs / docs-core
  出口   review → roadmap-planning
              │
              ▼
交付 delivery-stage
  roadmap-planning → execution-loop → code-review → git-commit → implementation-track
              │
              ▼
反馈 feedback-stage
  证据 → implementation-track / docs-audit / review / roadmap-planning
  回流 → design-stage（重新设计） / delivery-stage（修复）

任一段的会话边界 ──▶ session-handoff（外部工作记忆）
任一段的并行写   ──▶ parallel-worktree（独立 worktree + 分支）
多仓库提交       ──▶ multi-repo-commit（逐仓库提交/推送）
```

`docs-core` 是文档槽位基础；`skill-audit` 是 skill 仓库级审核，不进入项目交付流。

| 问题 | 用哪个 |
|---|---|
| 现在在设计、交付还是反馈 | **design-stage** / **delivery-stage** / **feedback-stage** |
| 新功能/新模块/新系统怎么设计、先定什么 | **design-stage** |
| 动态对象/生命周期怎么画图，类图或上下文地图够不够 | **design-stage**（图集）+ **responsibility-design**（边界） |
| 设计确认后怎么实现、审查、提交 | **delivery-stage** |
| 做完/试玩/测试后怎么回流到规划或设计 | **feedback-stage** |
| 这个会话太长了，要不要开新窗口 | **session-handoff** |
| 怎么把当前状态交接给新会话 | **session-handoff** |
| 多个会话同时改一个仓库怎么隔离 | **parallel-worktree** |
| 开 worktree/分支并行做两套方案 | **parallel-worktree** |
| 多个 worktree/分支怎么合并 | **parallel-worktree** |
| 一次任务改了多个仓库怎么提交 | **multi-repo-commit** |
| skills 和项目仓库都要提交 | **multi-repo-commit** |
| 不同域名/凭据的仓库一起推 | **multi-repo-commit** |
| 当前里程碑做什么、行为规则、怎么验收 | **game-docs** |
| 产品有哪些屏幕、怎么导航、状态归谁管 | **experience-architecture** |
| 新增模式/设置/结算页，壳层要不要改 | **experience-architecture** |
| 这个方案能不能过、附带什么条件 | **review** |
| 文档集有没有矛盾、过时、重复 | **docs-audit** |
| 哪些进 MVP / V1 / V2，先做哪个 | **roadmap-planning** |
| 怎么连续做到底、别每步问 | **execution-loop** |
| 这次改动有没有问题、合并前该跑哪些检查 | **code-review** |
| 模块职责怎么划、依赖怎么管、先修哪条 | **responsibility-design**（设计阶段或重构阶段） |
| 验收项做到哪了、偏差怎么记 | **implementation-track** |
| 代码现在是什么样 | **code-digest** |
| 外部生态 / 竞品 / 技术选型 | **topic-research** |
| 提交并推送 | **git-commit** |
| 审 skills 仓库的抽象分层/术语 | **skill-audit** |

## 共用约定

所有 skill 使用同一套语义，避免同名不同义（槽位与状态语义的完整定义见 `docs-core`）：

| 约定 | 规则 |
|---|---|
| 阶段 playbook | `design-stage` / `delivery-stage` / `feedback-stage` 只写本阶段入口、检查、出口与交接；生命周期图只在 README 维护 |
| 会话边界 | 一个工作包一个会话；切换前写一页 handoff；状态先落盘，临时推理不落盘 |
| 并行写 | 一个 worktree 一个写者；合并的是分支不是目录；共享接口/配置指定 owner |
| 多仓库提交 | 每个仓库独立提交/推送/验证；没有跨仓库原子提交；部分失败分别记录 |
| 文档类型 | `game-docs` 00~05、07 用 **game**（06 可选）；PRD + 各包 DESIGN.md 用 **software**；评审用 `review/profiles/` 下对应文件 |
| P0 / P1 | 只表示**验收优先级**：P0 必须通过，P1 可后置 |
| 代码问题级别 | `必须修 / 建议修 / 可选`，不要用 P0/P1 表示代码问题 |
| 术语 | 统一用「规则 / 合并前检查 / 必须修 / 基准值」；词表与废弃词扫描见 `skill-audit/references/terminology.md` |
| 体验架构 | 一页 Experience Map；产品状态与局内/会话状态分离；延后项必须有触发器 |
| 图设计 | 静态结构用上下文/类图；动态行为用状态图/时序图；类图不能证明生命周期接线；高风险变更补所有权/事件表 |
| 功能 / 包优先级 | `High / Medium / Low`，不要写成 P0/P1 |
| 状态标记 | `◻ 未开始 / 🔄 进行中 / ✅ 通过 / ❌ 失败` |
| 验收 ID | `AC-<类别>-<序号>`；跟踪 skill 直接引用，不另起编号 |
| 单一事实源 | 行为在 Spec，验收在 Acceptance，证据在 Review（试玩结论可并入）；规划只排期，跟踪只更新状态 |
| 交互边界 | 设计 / 方案 / 范围 / 取舍：先问用户；执行 / 提交 / 推送：直接做到目标，只在真实阻塞时停 |
| 不可逆操作 | force push、删分支/数据、部署、密钥操作：必须先问用户 |

## Skill 抽象边界

写 skill 时强制区分三层：通用规则 / 领域差异 / 示例。判据、扫描种子与检查清单见 `skill-audit`；新增或修改 skill 后跑一次。

## 安装

把 skill 目录复制到对应位置，支持 `.agents/skills` 的 agent 会自动发现：

**全局（所有项目可用）**

```sh
mkdir -p ~/.agents/skills
cp -r docs-core game-docs ~/.agents/skills/
```

**项目级（随仓库共享给协作者）**

```sh
mkdir -p <project>/.agents/skills
cp -r docs-core game-docs <project>/.agents/skills/
```

> `game-docs` 依赖 `docs-core`，需一并安装：两个目录都要在 `.agents/skills/` 下。其他 skill 可单独安装。

阶段 playbook、会话边界、并行工作区、连续执行与边界设计可按需安装：

```sh
cp -r design-stage delivery-stage feedback-stage session-handoff parallel-worktree multi-repo-commit execution-loop responsibility-design experience-architecture code-review ~/.agents/skills/
```

更新：重新执行复制命令覆盖即可；卸载：删除对应目录。

> `game-docs` 的脚手架 / 检查脚本是 Windows PowerShell；非 Windows 可手动复制 `references/templates/`，或使用 PowerShell 7。

装完在新会话中按 skill 的触发场景试探一句，确认能被自动加载。

## 新增/维护 skill

- 每个 skill 一个目录，目录名即 skill 名（小写字母数字、单连字符分隔）
- 目录内必须有 `SKILL.md`，以 YAML frontmatter 开头，`name` 必须与目录名一致，`description` 写清触发场景（何时用、何时不用）
- 若设置 `disable-model-invocation: true`，agent 不会自动加载该 skill，只能通过 `/` 命令菜单手动调用
- 个人/团队偏好（风格、术语、环境约定）放引用文件，`SKILL.md` 中只保留通用流程：这样其他团队/项目只需整体替换 `standards.md`，通用流程无需改动
- 仓库统一术语见 `skill-audit/references/terminology.md`；改完跑 `scripts/check-skills.sh`，废弃词零命中
- 引用文件用相对路径，如 `standards.md`、`templates/foo.md`
- 不要写死本机绝对路径；示例用 `<target>`、`<project>`
