# Skills

个人 agent skills 仓库。每个 skill 是独立目录，含 `SKILL.md`（入口）及可选的引用文件（规范、模板等）。

## 快速入口

| 场景 | 入口 |
|---|---|
| 只读讨论、调研、方案比较 | 主工作区；不建 worktree |
| 要改代码/文档/配置/资源 | `worktree-workflow`：先建独立 worktree |
| 新功能/新模块/新系统设计 | `design-stage` |
| 设计里有不可逆决定，需要 pre-mortem / kill criteria | `design-stage` + `references/decision-locks.md` |
| 游戏资源/随机/构筑/防错模式 | `game-docs` + `references/design-patterns.md` |
| 设计已确认，准备实现 | `delivery-stage` |
| 测试/试玩/评审后要回流 | `feedback-stage` |
| 当前里程碑/行为规则/验收 | `game-docs` |
| 把 LLM 接入游戏/工具 | `llm-integration` |
| 一次任务改多个仓库 | `multi-repo-commit` |
| 跨项目/跨仓库共同交付一项能力 | `cross-project-integration` |
| 会话太长或要交接 | `session-handoff` |
| 文档集/术语/仓库审核 | `docs-audit` / `skill-audit` |
| 准备把 skills 改动合并到 main | `skill-audit`（语义审计）+ CI / pre-push 硬检查 |
| 准备把 skills 改动合并到 main | `skill-audit`（默认自检门）+ `scripts/check-skills.sh` |

## 主流程

| 阶段 | 主流程 | 出口 |
|---|---|---|
| 设计 | `design-stage`：输入 → 体验架构/职责设计/图设计 → 文档规则 → 评审 → 规划 | `review` → `roadmap-planning` |
| 交付 | `delivery-stage`：`execution-loop` → `code-review` → `git-commit` → 验收状态 | `implementation-track` |
| 反馈 | `feedback-stage`：证据 → 分类 → 状态/文档更新 | 回流设计或交付 |

- 设计常用输入：`topic-research` / `code-digest` / `docs-audit` / `implementation-track`
- 设计常用方法：`experience-architecture` / `responsibility-design` / 图设计 / `game-docs` / `docs-core`

> `docs-core` 是文档槽位基础；`skill-audit` 是 skill 仓库级审核，不进入项目交付流。

## 横切能力

| 能力 | Skill | 规则 |
|---|---|---|
| 会话边界 | `session-handoff` | 一个工作包一个会话；切换前写 handoff |
| 读写分流 | `worktree-workflow` | 只读留主工作区；写任务独立 worktree |
| 多仓库提交 | `multi-repo-commit` | 每个仓库独立提交、推送、验证 |
| 跨项目协作 | `cross-project-integration` | 上下游、接口登记、依赖矩阵、冻结与集成计划 |
| LLM 接入 | `llm-integration` | 先探测端点，再接业务；失败必须降级 |
| Skill 维护 | `skill-audit` | 抽象分层、触发边界、术语与交叉引用 |

## Skill 索引

### 阶段 playbook

- **design-stage** — 设计阶段 playbook：输入 → 体验架构/职责设计/图设计 → 文档规则 → 评审 → 规划；含决策锁、Pre-mortem、Kill Criteria；只写本阶段入口、检查与出口
- **delivery-stage** — 交付阶段 playbook：入口确认 → 工作包执行 → 代码审查 → 提交 → 验收状态
- **feedback-stage** — 反馈阶段 playbook：证据收集与分类 → 状态/文档更新 → 评审/规划/设计回流

### 输入、文档与方法

- **topic-research** — 课题调研：生态全景、多入口交叉验证、证据分级
- **code-digest** — 代码库梳理：演进时间线 + 技术细节，防遗漏防过时、编号决策核对
- **docs-audit** — 文档集审核：交叉引用、术语一致性、版本锚点、重复与数字核对；含实现后漂移扫描与过时内容归档
- **implementation-track** — 实现跟踪：验收项状态（◻/🔄/✅/❌）与偏差记录回写
- **docs-core** — 通用文档体系规则：7 类文档、单一事实源、行为变更三件套、ADR 与状态语义
- **game-docs** — 游戏文档体系（基于 docs-core）：Run Brief、Design Spec、验收矩阵、ADR、试玩；含防错/资源经济/随机性/构筑阶段等设计模式
- **experience-architecture** — 产品体验架构：一页 Experience Map、屏幕/导航、状态所有权、生命周期与延后项
- **responsibility-design** — 职责驱动设计：上下文地图、所有权、依赖方向、生命周期所有权、边界违规与重构

### 实现与集成

- **llm-integration** — LLM 调用集成：模型档探测、受约束输出、失败降级、回放与高频选型
- **cross-project-integration** — 跨项目协作设计：上下游、接口登记、依赖矩阵、冻结与集成计划、生产者/消费者检查与跨项目交接

### 决策与规划

- **review** — 通用多角色评审：决策问题、角色意见、条件与行动项、证据、active/archive 索引
- **roadmap-planning** — 演进规划：把设计结论按依赖链归入 MVP/V1/V2（或 M0/M1/M2），定优先级与落点

### 交付与提交

- **execution-loop** — 连续执行闭环：一次确认目标，批量执行、自测、提交、更新跟踪，只在真实阻塞时停
- **code-review** — 代码审查与合并前检查：必须修/建议修/可选分级、改动类型 → 必跑检查、修复复跑
- **git-commit** — Git 提交：分析变更、按 Conventional Commits 生成 message、执行提交
- **worktree-workflow** — 任务读写分流：只读留主工作区，写任务默认独立 worktree + 短分支、合并与清理
- **multi-repo-commit** — 单会话多仓库提交：按仓库分组、分别提交推送、记录部分失败与跨仓库一致性

### 会话与维护

- **session-handoff** — 会话边界与外部记忆：继续/新开判断、一页 handoff、记忆分层、并行/模型切换
- **skill-audit** — Skill 仓库审核：抽象分层、触发边界、主动行为、术语一致性与交叉引用

## 核心约定

| 约定 | 规则 |
|---|---|
| 读写分流 | 只读讨论/调研留主工作区；写任务默认独立 worktree；主工作区只做集成/验证 |
| 会话边界 | 一个工作包一个会话；切换前写一页 handoff；状态先落盘 |
| 并行写 | 一个 worktree 一个写者；合并的是分支不是目录 |
| 多仓库提交 | 每个仓库独立提交/推送/验证；没有跨仓库原子提交 |
| 跨项目协作 | 接口登记、依赖矩阵、冻结点、集成 owner；见 `cross-project-integration` |
| 单一事实源 | 行为在 Spec，验收在 Acceptance，证据在 Review；规划只排期，跟踪只更新状态 |
| 状态 | `◻ 未开始 / 🔄 进行中 / ✅ 通过 / ❌ 失败` |
| 文档类型 | `game-docs` 00~05、07 用 game；PRD + 各包 DESIGN.md 用 software |
| 验收 ID | `AC-<类别>-<序号>`；跟踪 skill 直接引用，不另起编号 |
| 优先级 | P0/P1 只表示验收优先级；代码问题用必须修/建议修/可选；功能/包用 High/Medium/Low |
| 交互边界 | 设计/方案/范围/取舍先问；执行/提交/推送直接做到目标，只在真实阻塞时停 |
| 不可逆操作 | force push、删分支/数据、部署、密钥操作必须先问 |
| 术语 | 规则 / 合并前检查 / 必须修 / 基准值；详见 `skill-audit/references/terminology.md` |

## 安装

复制到 `~/.agents/skills/`（全局）或 `<project>/.agents/skills/`（项目级）。

最小：

```sh
mkdir -p ~/.agents/skills
cp -r docs-core game-docs ~/.agents/skills/
```

项目级：

```sh
mkdir -p <project>/.agents/skills
cp -r docs-core game-docs <project>/.agents/skills/
```

常用：

```sh
cp -r design-stage delivery-stage feedback-stage session-handoff worktree-workflow multi-repo-commit cross-project-integration execution-loop responsibility-design experience-architecture code-review ~/.agents/skills/
```

> `game-docs` 依赖 `docs-core`。更新时覆盖目录；卸载时删除目录。`game-docs` 脚本为 PowerShell；非 Windows 可手动复制 `references/templates/` 或使用 PowerShell 7。

## 合并前检查

机械检查由 CI / pre-push 硬检查负责：

- **CI**：`.github/workflows/skills-check.yml` 在 push / PR 时跑 `bash scripts/check-skills.sh`
- **本地 pre-push**：安装一次后，推送前自动跑同一脚本

```sh
bash scripts/install-git-hooks.sh
```

语义审计（抽象分层/触发边界/主动行为/职责重叠）仍由 `skill-audit` 负责；两者都通过才合并 `main`。

## 新增/维护 skill

- 先过 `skill-audit`：通用规则放 `SKILL.md`，个人/团队偏好放引用文件，项目细节标注为示例
- 每个 skill 一个目录，目录名即 skill 名；`SKILL.md` 的 `name` 必须与目录名一致
- `description` 写清触发场景：何时用、何时不用
- 设置 `disable-model-invocation: true` 后只能通过 `/` 命令手动调用
- 仓库术语见 `skill-audit/references/terminology.md`；改完跑 `scripts/check-skills.sh`，废弃词零命中
- **合并到 `main` 前默认自检**：确认 CI / pre-push 硬检查通过，并由 `skill-audit` 做语义审计；任一未通过不合并
- 引用文件用相对路径，如 `standards.md`、`templates/foo.md`；不要写死本机绝对路径
