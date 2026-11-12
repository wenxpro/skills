# Skills

个人 agent skills 仓库：每个 skill 一个目录，含 `SKILL.md`（入口）及可选的引用文件（规范、模板）。README 只做导航；每个 skill 的触发与边界见其 `description` 和「不适用」节。

> 所有 skill 由 `description` 的适用/不适用边界自动判断触发；需要时可用 `@skill-id` 显式指定，但不是必需前置。

## 快速入口

| 场景 | 入口 |
|---|---|
| 只读讨论、调研、方案比较 | 主工作区，不建 worktree |
| 要改代码/文档/配置/资源 | `worktree-workflow` |
| 新功能/模块/系统设计 | `design-stage` |
| 新软件项目 / 服务设计 | `design-stage` + `software-docs` + `backend-design` |
| 前端 / UI 规范与评审 | `ui-baseline` |
| 验收类别与证据 | `docs-core` + `references/acceptance-taxonomy.md` |
| 设计中有不可逆决定（pre-mortem / kill criteria） | `design-stage` + `references/decision-locks.md` |
| 验证阶段/实验设计/验证审计 | `validation-design` |
| 游戏机制测试场景/testbed/场景矩阵 | `validation-design`（`references/gameplay-testing.md`） |
| 战斗/兵种/攻击/数值模型 | `game-combat-model` + `validation-design` |
| 战斗/经济/成长/难度平衡 | `game-systems-balance` |
| 地图/据点/路线/遭遇设计 | `level-encounter-design` |
| 敌人 AI/反制/公平性 | `game-ai-design` + `validation-design` |
| AI/系统难度调参 | `game-ai-design` + `game-systems-balance` |
| 设计已确认，准备实现 | `delivery-stage` |
| 测试/试玩/评审后回流 | `feedback-stage` |
| 当前里程碑/行为规则/验收 | `game-docs` |
| 游戏资源/随机/构筑/防错模式 | `game-docs` + `references/design-patterns.md` |
| 把 LLM 接入项目 | `llm-integration` |
| 一次任务改多个仓库 | `git-commit`（多仓库模式） |
| 跨项目/跨仓库共同交付 | `cross-project-integration` |
| 会话太长或要交接 | `session-handoff` |
| 文档集/术语审核 | `docs-audit` |
| skills 仓库审核与合并 | `skill-audit` + CI / pre-push |

## 主流程

| 阶段 | 入口 | 出口 |
|---|---|---|
| 设计 | `design-stage`：输入 → 体验架构/职责设计/图设计 → 文档规则 → 评审 → 规划 | `review` → `roadmap-planning` |
| 交付 | `delivery-stage`：`execution-loop` → `code-review` → `git-commit` → 验收状态 | `implementation-track` |
| 反馈 | `feedback-stage`：证据 → 分类 → 状态/文档更新 | 回流设计或交付 |

- 设计输入：`topic-research` / `code-digest` / `docs-audit` / `implementation-track`
- 设计方法：`experience-architecture` / `responsibility-design` / `game-docs` / `docs-core` / `software-docs` / `backend-design` / `ui-baseline`
- 验证方法：`validation-design`（假设/失败判据/反事实/证据层级）；游戏战斗模型：`game-combat-model`

## 横切能力

| 能力 | Skill | 规则 |
|---|---|---|
| 会话边界 | `session-handoff` | 一个工作包一个会话；切换前写 handoff |
| 读写分流 | `worktree-workflow` | 只读留主工作区；写任务独立 worktree |
| 多仓库提交 | `git-commit`（多仓库模式） | 每个仓库独立提交、推送、验证 |
| 跨项目协作 | `cross-project-integration` | 接口登记、依赖矩阵、冻结点、集成 owner |
| LLM 接入 | `llm-integration` | 先探测端点再接业务；失败必须降级 |
| Skill 维护 | `skill-audit` | 抽象分层、触发边界、主动行为、术语 |

## Skill 索引

### 阶段

| Skill | 触发 | 定位 |
|---|---|---|
| `design-stage` | 自动 | 设计阶段 playbook：输入、检查、出口；决策锁、pre-mortem、kill criteria |
| `delivery-stage` | 自动 | 交付阶段 playbook：执行、代码审查、提交、验收状态 |
| `feedback-stage` | 自动 | 反馈阶段 playbook：证据收集、分类、回流 |

### 基础与方法

| Skill | 触发 | 定位 |
|---|---|---|
| `docs-core` | 自动 | 文档槽位规则、单一事实源、变更三件套、状态语义、验收类别 |
| `game-docs` | 自动 | 游戏文档体系（基于 docs-core）+ 游戏设计模式 |
| `software-docs` | 自动 | 软件项目文档体系：PRD、架构、接口、数据、安全、运行手册、验收、ADR |
| `backend-design` | 自动 | 后端/服务设计：边界、接口、数据、安全、可靠性 |
| `ui-baseline` | 自动 | 前端/UI 基线：token、组件状态、屏幕规格、平台规范、无障碍 |
| `experience-architecture` | 自动 | 产品体验架构：Experience Map、屏幕/导航、状态所有权 |
| `responsibility-design` | 自动 | 职责驱动设计：上下文地图、依赖方向、边界违规、重构 |
| `validation-design` | 自动 | 验证阶段设计与测试设计：假设、变量、指标、失败判据、反事实、证据层级；L0–L4 测试层、testbed、fixture、场景矩阵 |
| `game-combat-model` | 自动 | 战斗模型：角色差异、攻击时间轴、TTK、克制预算、对决矩阵、反事实 sim |
| `game-systems-balance` | 自动 | 系统平衡：TTK/胜率/克制、经济来源/消耗、成长曲线、难度、支配性与敏感性 |
| `level-encounter-design` | 自动 | 关卡/遭遇：目标/路线/出生/掩体/视野/节奏/旋转对称（默认 180°）/可读性 |
| `game-ai-design` | 自动 | 游戏 AI：感知、目标选择、推进/撤退、难度、反制、可读性、不作弊 |

### 输入与决策

| Skill | 触发 | 定位 |
|---|---|---|
| `topic-research` | 自动 | 外部调研：生态全景、交叉验证、证据分级 |
| `code-digest` | 自动 | 代码库梳理：演进时间线、技术细节、编号决策核对 |
| `docs-audit` | 自动 | 文档集审核：引用、术语、时效、漂移、ID 覆盖 |
| `implementation-track` | 自动 | 验收跟踪与偏差记录 |
| `review` | 自动 | 多角色评审：结论、条件、行动项、证据 |
| `roadmap-planning` | 自动 | 跨版本规划：MVP/V1/V2、M/W 映射、优先级与落点 |

### 交付与集成

| Skill | 触发 | 定位 |
|---|---|---|
| `execution-loop` | 自动 | 连续执行闭环：一次确认目标，批量执行到验收 |
| `code-review` | 自动 | 代码审查：分级、必跑检查、修复复跑 |
| `git-commit` | 自动 | Conventional Commits；单仓库与多仓库 |
| `worktree-workflow` | 自动 | 读写分流与 worktree 生命周期 |
| `llm-integration` | 自动 | LLM 集成：模型探测、受约束输出、降级、回放 |
| `cross-project-integration` | 自动 | 跨项目协作：接口登记、依赖矩阵、冻结与集成计划 |

### 会话与维护

| Skill | 触发 | 定位 |
|---|---|---|
| `session-handoff` | 自动 | 会话边界与外部记忆 |
| `skill-audit` | 自动 | skills 仓库审核与合并门 |

## 核心约定

| 约定 | 规则 |
|---|---|
| 交互边界 | 设计/方案/范围/取舍先问；执行/提交/推送直接做到目标，只在真实阻塞时停 |
| 不可逆操作 | force push、删分支/数据、部署、密钥操作必须先问 |
| 单一事实源 | 行为在 Spec，验收在 Acceptance，证据在 Review；规划只排期，跟踪只更新状态 |
| 状态 | `◻ 未开始 / 🔄 进行中 / ✅ 通过 / ❌ 失败` |
| 文档类型 | `game-docs` 00~05、07 用 game；`software-docs` 00~10 用 software；其他项目按 `docs-core` 槽位裁剪 |
| 验收 ID | `AC-<类别>-<序号>`；类别与证据见 `docs-core/references/acceptance-taxonomy.md` |
| 优先级 | P0/P1 只表示验收优先级；代码问题用必须修/建议修/可选；功能/包用 High/Medium/Low |
| 术语 | 规则 / 合并前检查 / 必须修 / 基准值；详见 `skill-audit/references/terminology.md` |

## 领域扩展

- 三层协议：设计 → 评审 → 验收；规划、交付、反馈是外围阶段，不塞进三层。
- 垂直领域用三件套挂接：`design`（方法/默认值/失败模式）、`review`（角色/否决/证据）、`acceptance`（AC 类别/证据/样例）。
- 当前切片：`game-docs`（游戏）、`software-docs`（软件文档）、`backend-design`（后端）、`ui-baseline`（前端/UI）。
- 验收类别与证据阶梯统一在 `docs-core/references/acceptance-taxonomy.md`；垂直 skill 只引用，不重复维护。
- 新增垂直领域时先判断能否复用现有切片；只有在触发边界独立时才新建 skill。

## 安装

复制到 `~/.agents/skills/`（全局）或 `<project>/.agents/skills/`（项目级）。

**最小（游戏）**

```sh
mkdir -p ~/.agents/skills
cp -r docs-core game-docs ~/.agents/skills/
```

**最小（软件）**

```sh
mkdir -p ~/.agents/skills
cp -r docs-core software-docs ~/.agents/skills/
```

**项目级**

```sh
mkdir -p <project>/.agents/skills
cp -r docs-core game-docs <project>/.agents/skills/
```

**常用**

```sh
cp -r design-stage delivery-stage feedback-stage session-handoff worktree-workflow cross-project-integration execution-loop responsibility-design experience-architecture code-review software-docs backend-design ui-baseline ~/.agents/skills/
```

> 所有 skill 都通过 `description` 自动判断是否加载；需要时可用 `@skill-id` 显式指定。
> `game-docs` / `software-docs` 依赖 `docs-core`。`backend-design` 与 `ui-baseline` 的输出落到 `software-docs` 定义的槽位，但可独立使用。
> 更新时覆盖目录；卸载时删除目录。`game-docs` 脚本为 PowerShell；非 Windows 可手动复制 `references/templates/` 或使用 PowerShell 7。

## 维护与合并检查

- 新增/修改 skill 先过 `skill-audit`：通用规则放 `SKILL.md`，个人/团队偏好放引用文件，项目细节标注为示例
- 目录名 = skill 名；`SKILL.md` 的 `name` 必须与目录名一致；`description` 写清何时用、何时不用
- 触发边界靠 `description` 的「适用/不适用」与负面清单；不要用手动开关代替触发设计
- 引用文件用相对路径，如 `standards.md`、`templates/foo.md`；不要写死本机绝对路径
- 仓库术语见 `skill-audit/references/terminology.md`；改完跑 `scripts/check-skills.sh`，废弃词零命中

合并 `main` 前必须同时通过：

- **机械检查**：CI（`.github/workflows/skills-check.yml`）或本地 pre-push 跑 `bash scripts/check-skills.sh`
- **语义审计**：`skill-audit`（抽象分层、触发边界、主动行为、职责重叠）

本地安装 pre-push：

```sh
bash scripts/install-git-hooks.sh
```
