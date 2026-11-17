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
| 打击反馈/hitstop/震屏/闪白/trail | `game-feel` + `game-combat-model` |
| 潜行/劫掠/追逃/风险资源 | `game-stealth` |
| 选择/后果/回访/结局收敛 | `game-choice-consequence` + `narrative-docs` |
| Roguelite 单局/构筑/进化/内容池 | `game-roguelite` + `game-systems-balance` |
| 音频总线/混音/循环/音量持久化 | `game-audio` |
| 音频配置/目录/候选库/安全应用 | `game-audio`（`references/audio-catalog.md`） |
| 3D 角色/骨骼/重定向/脚底接触 | `game-animation-rig`（程序化代理见 `references/procedural-proxy.md`） |
| Godot 运行时/headless/音频总线/设置持久化 | `godot-game-runtime` |
| 截图矩阵/前后对比/视觉证据 | `validation-design`（`references/visual-evidence.md`） |
| 性能预算/测量/回归 | `validation-design`（`references/performance-budget.md`） |
| LLM 试玩协议/回放/评估 | `llm-integration`（`references/playtest-protocol.md`） |
| Windows 编码/行尾/并行 Git | `git-commit`（`references/windows-hygiene.md`） |
| 战斗/经济/成长/难度平衡 | `game-systems-balance` |
| 地图/据点/路线/遭遇设计 | `level-encounter-design` |
| 敌人 AI/反制/公平性 | `game-ai-design` + `validation-design` |
| AI/系统难度调参 | `game-ai-design` + `game-systems-balance` |
| 设计已确认，准备实现 | `delivery-stage` |
| 测试/试玩/评审后回流 | `feedback-stage` |
| 当前里程碑/行为规则/验收 | `game-docs` |
| 长剧本/叙事项目的故事文档 | `narrative-docs` + `review`（narrative profile） |
| 游戏资源/随机/构筑/防错模式 | `game-docs` + `references/design-patterns.md` |
| 把 LLM 接入项目 | `llm-integration` |
| 一次任务改多个仓库 | `git-commit`（多仓库模式） |
| 跨项目/跨仓库共同交付 | `cross-project-integration` |
| 会话太长或要交接 | `session-handoff` 手改 |
| 文档集/术语审核 | `docs-audit` |
| skills 仓库审核与合并 | `skill-audit` + CI / pre-push |

## 主流程

| 阶段 | 入口 | 出口 |
|---|---|---|
| 设计 | `design-stage`：输入 → 体验架构/职责设计/图设计 → 文档规则 → 评审 → 规划 | `review` → `roadmap-planning` |
| 交付 | `delivery-stage`：`execution-loop` → `code-review` → `git-commit` → 验收状态 | `implementation-track` |
| 反馈 | `feedback-stage`：证据 → 分类 → 状态/文档更新 | 回流设计或交付 |

- 设计输入：`topic-research` / `code-digest` / `docs-audit` / `implementation-track`
- 设计方法：`experience-architecture` / `responsibility-design` / `game-docs` / `narrative-docs` / `docs-core` / `software-docs` / `backend-design` / `ui-baseline`
- 验证方法：`validation-design`（假设/失败判据/反事实/证据层级）；游戏战斗模型：`game-combat-model`；动画/反馈：`game-animation-rig` / `game-feel`

## 横切能力

| 能力 | Skill | 规则 |
|---|---|---|
| 会话边界 | `session-handoff` 手改 | 一个工作包一个会话；切换前写 handoff |
| 读写分流 | `worktree-workflow` | 只读留主工作区；写任务独立 worktree |
| 多仓库提交 | `git-commit`（多仓库模式） | 每个仓库独立提交、推送、验证 |
| 跨项目协作 | `cross-project-integration` | 接口登记、依赖矩阵、冻结点、集成 owner |
| LLM 接入 | `llm-integration` | 先探测端点再接业务；失败必须降级 |
| Skill 维护 | `skill-audit` | 抽象分层、触发边界、主动行为、术语 |

## Skill 索引

> 本节由 `scripts/gen-readme-index.sh` 从各 SKILL.md 的 description 首句生成，勿手改。分类映射在脚本内维护；新增 skill 需登记后运行 `bash scripts/gen-readme-index.sh` 重新生成，CI 会校验同步。

<!-- BEGIN GENERATED: skill-index -->
### 阶段

| Skill | 定位 |
|---|---|
| `design-stage` | 设计阶段 playbook：选择调研/代码/文档/验收输入，定体验架构、职责边界、图设计（上下文/生命周期/时序）与文档规则，过评审后交给规划 |
| `delivery-stage` | 交付阶段 playbook：确认设计与规划入口，按工作包实现，过代码审查和改动检查后提交，并更新验收状态 |
| `feedback-stage` | 反馈阶段 playbook：收集测试、试玩、审查与文档证据，区分通过/失败/偏差/过时，更新验收状态并回流到设计、规划或修复 |

### 基础与方法

| Skill | 定位 |
|---|---|
| `docs-core` | 通用文档体系规则：7 类文档（入口/假设/规则/验收/决策/证据/检查）、单一事实源、行为变更三件套、状态语义、验收类别 |
| `game-docs` | 游戏项目文档体系：Run Brief、Design Spec、验收矩阵、ADR、试玩；含 M0/M1/M2 与 P0/P1 约定 |
| `narrative-docs` | 长剧本/叙事项目文档体系：Story Brief、World Bible、Character Bible、Structure、Scene Cards、Voice Guide、Continuity、Revision、Read-through；基于 docs-core 的 7 类槽位 |
| `software-docs` | 软件项目文档体系与模板：PRD、架构、接口、数据、安全、运行手册、验收、ADR 与证据；槽位规则见 docs-core |
| `backend-design` | 后端/服务运行时设计：部署与故障域、对外接口约定、数据模型、威胁建模、可靠性 |
| `ui-baseline` | 前端/UI 设计基线：语义 token、组件状态、屏幕规格、平台规范、无障碍与评审检查表 |
| `experience-architecture` | 产品体验架构：用一页 Experience Map 定义屏幕、导航、状态所有权、生命周期、入口/退出与延后项；在新增模式/屏幕/入口前做触发检查 |
| `responsibility-design` | 职责驱动设计：设计阶段定义上下文、模块所有权、依赖方向、接口与状态边界；实现/重构阶段识别边界违规、组合根膨胀与行为保持重构；轻量 DDD，不默认聚合根/仓储/事件总线 |
| `validation-design` | 验证阶段设计与游戏机制测试设计：模型假设、变量/控制、指标、失败判据、反事实、证据层级与决策规则；L0–L4 测试层、fixture、场景矩阵与 testbed |
| `game-combat-model` | 战斗模型设计：角色差异化、攻击时间轴、TTK/命中数、克制预算、对决矩阵、支配性与确定性模拟 |
| `game-systems-balance` | 系统平衡设计：战斗/经济/成长/难度/掉落的基准值、P50/P90、支配性与敏感性分析、调参矩阵 |
| `level-encounter-design` | 关卡与遭遇设计：目标/路线/出生/掩体/视野/节奏；对局地图优先旋转对称（默认 180°）、首个可玩切片单一目标、可读接战 |
| `game-ai-design` | 游戏 AI 设计：感知、目标选择、推进/撤退、难度、反制与可读性；不锁血/不偷资源/不超视野 |

### 游戏实现

| Skill | 定位 |
|---|---|
| `godot-game-runtime` | Godot 4.x 运行时与工程集成：项目配置、InputMap、AnimationTree 接口、AudioServer 总线、user:// 持久化、headless CLI、测试场景、截图入口与导入/UID 管理 |
| `game-animation-rig` | 3D 角色/骨骼/动画管线：资产坐标与 scale、重定向、Hips Y、脚底接触、动画状态机、武器挂点、接触帧事件、移动/转身表现 |
| `game-feel` | 游戏打击与反馈：contact 帧对齐、hitstop、镜头震动、闪白、trail、音效/震动分层与可读性预算 |
| `game-audio` | 游戏音频架构：Master/分组总线、SFX 与音乐路由、运行时合成音、循环接缝、混音与音量/静音持久化、voice 管理、headless 跳过 |
| `game-stealth` | 潜行与风险设计：检测模型、警戒状态、遮挡/噪音、潜行手段、风险资源、追逃与失败恢复、可读性 |
| `game-choice-consequence` | 选择与后果系统：选择节点、状态标记、信息差、延迟回访、结局收敛、道德/经济后果、内容表 |
| `game-roguelite` | Roguelite 单局与构筑：单局节奏、奖励/升级、构筑轴、进化条件、内容池、局内/局外进度、确定性种子 |

### 输入与决策

| Skill | 定位 |
|---|---|
| `topic-research` | 外部课题调研：生态全景、多入口交叉验证、假设与验证分离、证据分级 |
| `code-digest` | 代码库梳理：git 历史 + 语义记录建演进时间线，文档先行读源码，防遗漏防过时，编号决策核对 |
| `docs-audit` | 文档集审核：交叉引用、术语一致性、翻译腔、版本锚点、验证表述、图表、重复、数字、实现后漂移、ID 覆盖、过时内容归档 |
| `implementation-track` | 验收跟踪与偏差记录：状态（◻/🔄/✅/❌）、四段式偏差、证据阶梯、最小 fake 接口 |
| `review` | 通用多角色评审：决策问题、角色意见、条件与行动项、证据、active/archive 索引 |
| `roadmap-planning` | 跨版本演进规划：设计结论按依赖链归入 MVP/V1/V2 或 M0/M1/M2，含 M/W 两层映射，定优先级与落点 |

### 交付与集成

| Skill | 定位 |
|---|---|
| `execution-loop` | 连续执行闭环：一次确认目标/DoD/约束，之后连续执行、自测、提交、更新跟踪，只在真实阻塞时停 |
| `code-review` | 代码审查与合并前检查：审查 diff/实现，输出必须修/建议修/可选的问题与测试结果；按改动类型列出必须跑的检查（配置校验、重开一致性、UI 数量与刷新频率、内容表、性能），修复后复跑 |
| `git-commit` | Git 提交（单仓库/多仓库）：按 Conventional Commits 生成 message，直接提交推送；多仓库按仓库分组、分别提交推送、记录部分失败与跨仓库一致性 |
| `worktree-workflow` | 任务读写分流与 Git 工作树：只读讨论/调研留主工作区，任何写任务默认独立 worktree + 短分支，主工作区只做集成与验证 |
| `llm-integration` | LLM 调用集成：模型档探测、受约束输出、失败降级、回放与高频选型 |
| `cross-project-integration` | 跨项目协作设计：一项能力由两个以上仓库、团队或发布节奏共同交付时，定义上下游、接口登记、依赖矩阵、冻结与集成计划、生产者/消费者检查与跨项目交接 |

### 会话与维护

| Skill | 定位 |
|---|---|
| `session-handoff` | 会话边界与外部记忆：判断继续当前会话还是新开窗口，用一页 handoff 外置目标、状态、决策、下一步、约束与验证；新会话先复述再验证 |
| `skill-audit` | Skills 仓库审核：抽象分层、结构、触发边界、主动行为/干预策略、术语一致性、交叉引用、职责重叠、合并/拆分评估，以及行为评估/证伪；skills 项目合并到 main 前默认自检 |

<!-- END GENERATED: skill-index -->

## 核心约定

| 约定 | 规则 |
|---|---|
| 交互边界 | 设计/方案/范围/取舍先问；执行/提交/推送直接做到目标，只在真实阻塞时停 |
| 不可逆操作 | force push、删分支/数据、部署、密钥操作必须先问 |
| 单一事实源 | 行为在 Spec，验收在 Acceptance，证据在 Review；规划只排期，跟踪只更新状态 |
| 状态 | `◻ 未开始 / 🔄 进行中 / ✅ 通过 / ❌ 失败` |
| 文档类型 | `game-docs` 00~05、07 用 game；`narrative-docs` 00~12 用 narrative；`software-docs` 00~10 用 software；其他项目按 `docs-core` 槽位裁剪 |
| 验收 ID | `AC-<类别>-<序号>`；类别与证据见 `docs-core/references/acceptance-taxonomy.md` |
| 优先级 | P0/P1 只表示验收优先级；代码问题用必须修/建议修/可选；功能/包用 High/Medium/Low |
| 术语 | 规则 / 合并前检查 / 必须修 / 基准值；详见 `skill-audit/references/terminology.md` |

## 领域扩展

- 三层协议：设计 → 评审 → 验收；规划、交付、反馈是外围阶段，不塞进三层。
- 垂直领域用三件套挂接：`design`（方法/默认值/失败模式）、`review`（角色/否决/证据）、`acceptance`（AC 类别/证据/样例）。
- 当前切片：`game-docs`（游戏）、`narrative-docs`（长剧本/叙事）、`software-docs`（软件文档）、`backend-design`（后端）、`ui-baseline`（前端/UI）。
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

**最小（叙事）**

```sh
mkdir -p ~/.agents/skills
cp -r docs-core narrative-docs review ~/.agents/skills/
```

**项目级**

```sh
mkdir -p <project>/.agents/skills
cp -r docs-core game-docs <project>/.agents/skills/
```

**常用**

```sh
cp -r design-stage delivery-stage feedback-stage session-handoff worktree-workflow cross-project-integration execution-loop responsibility-design experience-architecture code-review software-docs narrative-docs backend-design ui-baseline ~/.agents/skills/
```

> 所有 skill 都通过 `description` 自动判断是否加载；需要时可用 `@skill-id` 显式指定。
> `game-docs` / `narrative-docs` / `software-docs` 依赖 `docs-core`。`narrative-docs` 的评审角色在 `review/profiles/narrative.md`。`backend-design` 与 `ui-baseline` 的输出落到 `software-docs` 定义的槽位，但可独立使用。
> 更新时覆盖目录；卸载时删除目录。`game-docs` 脚本为 PowerShell；非 Windows 可手动复制 `references/templates/` 或使用 PowerShell 7。

## 维护与合并检查

- 新增/修改 skill 先过 `skill-audit`：通用规则放 `SKILL.md`，个人/团队偏好放引用文件，项目细节标注为示例
- 高风险/触发重叠改动加行为评估：按 `skill-audit/references/evaluation.md` 跑触发回归 + 消融，报告用 `skill-audit/templates/eval-report.md`
- 目录名 = skill 名；`SKILL.md` 的 `name` 必须与目录名一致；`description` 写清何时用、何时不用
- 触发边界靠 `description` 的「适用/不适用」与负面清单；不要用手动开关代替触发设计
- 引用文件用相对路径，如 `standards.md`、`templates/foo.md`；不要写死本机绝对路径
- 仓库术语见 `skill-audit/references/terminology.md`；改完跑 `scripts/check-skills.sh`，废弃词零命中
- 新增/改名 skill 或改 description 后，在 `scripts/gen-readme-index.sh` 登记分类并运行它重建索引；README 索引节勿手改

合并 `main` 前必须同时通过：

- **机械检查**：CI（`.github/workflows/skills-check.yml`）或本地 pre-push 跑 `bash scripts/check-skills.sh`
- **语义审计**：`skill-audit`（抽象分层、触发边界、主动行为、职责重叠）

本地安装 pre-push：

```sh
bash scripts/install-git-hooks.sh
```
