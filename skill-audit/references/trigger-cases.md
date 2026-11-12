# 触发回归清单

改过任何 skill 的 `description` 后，用这些句子验证触发是否正确。

## 读写分流

| 输入 | 期望 | 不期望 |
|---|---|---|
| 「先只读讨论/调研，不要改文件」 | 留在主工作区 | 创建 worktree/分支 |
| 「只读审查这个 diff」 | 留在主工作区 | 主动创建 worktree |
| 「讨论完了，开始改文档/代码」 | 先建独立 worktree，再落盘 | 直接在主工作区编辑 |
| 「这次只改一个文档，也要开 worktree 吗」 | 要；判据是是否写，不是改动大小 | 以改动小为由跳过 |
| 「要改文件但还没建 worktree」 | 先建 worktree，再编辑 | 直接编辑 |
| 「删 worktree 报 Directory not empty」 | worktree-workflow（「目录删不掉：进程占用」） | 反复 `rm -rf`、重装 Git |
| 「worktree 目录删了又自动出现」 | worktree-workflow，用 `lsof +D` 定位持有进程 | 重建 worktree 或 `worktree prune` |
| 「worktree 放项目里还是项目外」 | worktree-workflow；项目外或扫描排除 | 默认放项目根目录 |

## 阶段与执行

| 输入 | 期望触发 | 不应触发 |
|---|---|---|
| 「新模块/新系统怎么设计，先定什么」 | design-stage | delivery-stage、code-review |
| 「设计阶段该补哪些输入、按什么轨道做」 | design-stage | delivery-stage、code-review |
| 「动态对象的生命周期怎么画图」 | design-stage | delivery-stage、code-review |
| 「类图/上下文地图够不够证明生命周期」 | design-stage | delivery-stage、code-review |
| 「设计确认了，怎么组织实现、审查和提交」 | delivery-stage | design-stage、review、execution-loop |
| 「交付阶段该拆哪些工作包、跑哪些检查」 | delivery-stage | code-review、execution-loop |
| 「试玩/测试完了，怎么回流到规划或设计」 | feedback-stage | delivery-stage、execution-loop |
| 「验收失败/文档过时，下一步怎么处理」 | feedback-stage | implementation-track、docs-audit |
| 「这个会话太长了，要不要开新窗口」 | session-handoff | execution-loop、worktree-workflow、feedback-stage |
| 「怎么把当前状态交接给新会话」 | session-handoff | docs-core、execution-loop、worktree-workflow |
| 「要改代码/文档/配置，先做什么」 | worktree-workflow | git-commit、code-review |
| 「讨论完了开始写，什么时候建 worktree」 | worktree-workflow | session-handoff、git-commit |
| 「两个会话同时改这个仓库，怎么隔离」 | worktree-workflow | session-handoff、git-commit |
| 「开个 worktree 并行做两套方案」 | worktree-workflow | execution-loop、git-commit |
| 「多个 worktree 怎么合并」 | worktree-workflow | git-commit、multi-repo-commit、code-review |
| 「一个分支能不能开两个会话写」 | worktree-workflow | session-handoff、execution-loop |
| 「一次任务改了多个仓库怎么提交」 | multi-repo-commit | git-commit、session-handoff |
| 「skills 和项目仓库都要提交」 | git-commit（多仓库模式） | worktree-workflow |
| 「不同域名/凭据的仓库一起推」 | multi-repo-commit | worktree-workflow、git-commit |
| 「接下来做什么？V1 和 V2 怎么拆」 | roadmap-planning | execution-loop、implementation-track |
| 「做到 M1 验收全过再汇报，别每步问我」 | execution-loop | roadmap-planning、delivery-stage、session-handoff |
| 「验收项做到哪了？偏差怎么记」 | implementation-track | execution-loop、roadmap-planning |
| 「评审一下这个方案，能不能过」 | review | docs-audit、code-review、experience-architecture |
| 「审一下这次改动有没有坑」 | code-review | review、docs-audit |
| 「合并前该跑哪些验证」 | code-review | execution-loop |
| 「审核一下这套文档，有没有矛盾过时」 | docs-audit | review、code-review |
| 「这套文档有旧版本/过时内容，顺手归档」 | docs-audit | review、game-docs、feedback-stage |

## 跨项目协作

| 输入 | 期望触发 | 不应触发 |
|---|---|---|
| 「两个仓库共同交付一个功能，怎么定接口和顺序」 | cross-project-integration | responsibility-design、roadmap-planning |
| 「多个窗口/子代理并行改同一个仓库，怎么分写集」 | worktree-workflow + cross-project-integration | 直接并行写同一文件 |
| 「LLM 迁移和游戏内容线怎么排期」 | cross-project-integration | roadmap-planning 单独排两套计划 |
| 「只改一个仓库的模块边界」 | responsibility-design | cross-project-integration |
| 「多仓库分别提交」 | multi-repo-commit | cross-project-integration、git-commit |
| 「迁移新旧路径怎么切换」 | cross-project-integration | llm-integration、delivery-stage |

## 文档与代码

| 输入 | 期望触发 | 不应触发 |
|---|---|---|
| 「给新游戏建一套设计文档」 | game-docs | docs-core、docs-audit、experience-architecture |
| 「什么内容该写进哪篇文档」 | docs-core | game-docs、experience-architecture |
| 「产品有哪些屏幕、怎么导航、状态归谁管」 | experience-architecture | game-docs、docs-core |
| 「新增试炼场/设置/结算页，壳层要不要改」 | experience-architecture | game-docs、responsibility-design |
| 「梳理一下这个项目的演进和模块细节」 | code-digest | responsibility-design、topic-research |
| 「模块边界太乱，先修哪条依赖」 | responsibility-design | code-digest、experience-architecture |
| 「新模块的职责边界和依赖方向怎么定」 | responsibility-design | code-digest、design-stage |
| 「动态对象由谁创建/注册/清理」 | responsibility-design | docs-audit、delivery-stage |
| 「上下文地图为什么没发现生命周期问题」 | responsibility-design | docs-audit、code-review |
| 「调研一下终端 UI 生态」 | topic-research | code-digest |
| 「把 LLM 接进游戏，JSON 总是不稳」 | llm-integration | design-stage、code-review |
| 「本地模型返回空 content / 一直 thinking，怎么排查」 | llm-integration | topic-research |
| 「LLM 调用怎么加 fallback 和回放」 | llm-integration | design-stage、execution-loop |
| 「泛化调研 2026 小模型生态」 | topic-research | llm-integration |
| 「提交并推送」 | git-commit | execution-loop、worktree-workflow、multi-repo-commit |
| 「审一下 skills 仓库的抽象分层」 | skill-audit | docs-audit |
| 「检查一下 skills 仓库的术语是否统一」 | skill-audit | docs-audit |
| 「准备把 skills 改动合并到 main」 | `skill-audit`（语义审计）+ CI / pre-push 硬检查 | docs-audit |
| 「改完 skill 直接 merge」 | 先确认 CI / pre-push 与 skill-audit；未通过不合并 | 直接 git merge |
| 「这些 skill 总是前后一起用，能不能合并」 | skill-audit + `references/consolidation.md` | docs-audit、review |
| 「这个 skill 该合并、拆分还是改名」 | skill-audit | review |
| 「检查一下文档里的术语是否统一」 | docs-audit | skill-audit |

## 验证、战斗与游戏系统设计

| 输入 | 期望触发 | 不应触发 |
|---|---|---|
| 「验证阶段怎么设计，怎么算通过/失败」 | validation-design | game-docs、review |
| 「现有验证计划只有成功截图，够不够」 | validation-design | docs-audit、game-docs |
| 「怎么做反事实/消融验证」 | validation-design | code-review、feedback-stage |
| 「移动/碰撞验证要不要引入敌人」 | validation-design（gameplay-testing） | game-combat-model、game-docs |
| 「攻击验证要不要完整敌人 AI」 | validation-design + game-combat-model | game-docs、review |
| 「怎么设计 testbed / 场景矩阵 / 假人」 | validation-design（gameplay-testing） | game-docs |
| 「测试层级 L0–L4 和 fixture 怎么定」 | validation-design（gameplay-testing） | implementation-track、code-review |
| 「战斗/兵种/攻击模型怎么设计，为什么都同频率」 | game-combat-model + validation-design | game-docs、ui-baseline |
| 「攻击力/频率/克制/ TTK 怎么定」 | game-combat-model + game-systems-balance | validation-design（只做验证计划时再用）、code-review |
| 「经济来源/消耗/成长/难度怎么定」 | game-systems-balance | game-combat-model、game-docs |
| 「地图/据点/路线/低墙/遭遇怎么设计」 | level-encounter-design | ui-baseline、game-docs |
| 「AI 为什么很蠢/作弊/没有反制」 | game-ai-design + validation-design | llm-integration、code-review |
| 「AI 难度怎么调才公平」 | game-ai-design + game-systems-balance | game-docs、review |
| 「1v1 能不能证明 2v2 战斗模型」 | validation-design + game-combat-model | game-docs、review |
| 「验收矩阵怎么写」 | game-docs | validation-design、docs-core |

## 软件文档、后端与 UI

| 输入 | 期望触发 | 不应触发 |
|---|---|---|
| 「给新软件项目建一套文档」 | software-docs | game-docs、docs-core、docs-audit |
| 「什么内容写进 PRD/架构/接口/数据/安全/运行手册」 | software-docs | backend-design、docs-core |
| 「新服务的边界/接口/数据/安全/可靠性怎么设计」 | backend-design | responsibility-design、software-docs |
| 「多个服务怎么定接口版本和幂等」 | backend-design | cross-project-integration（跨仓库登记时再加） |
| 「前端 UI 规范、组件状态、平台规范、无障碍」 | ui-baseline | experience-architecture、code-review |
| 「验收怎么分类、证据要到什么程度」 | docs-core（`references/acceptance-taxonomy.md`） | implementation-track、software-docs |

## 多轮行为与干预策略

| 场景 | 期望行为 |
|---|---|
| 提示新开会话后，用户说「继续」 | 不重复提示，继续当前会话；到下一个工作包边界再判断 |
| 用户说「先别换」 | 当前工作包内不再提示；记录决定 |
| 上下文很长但没有 handoff | 先补目标/状态/下一步/验证；不直接建议新开 |
| 新会话只拿到旧 handoff | 先复述并验证；过期则标 `Superseded` |
| skill 每轮都主动提示 | 视为缺陷：检查频率/拒绝后/边界 |
| 信息不足时直接建议新开/提交 | 视为缺陷：应先继续或补状态 |
| 提示后用户拒绝，下一轮又提示 | 视为缺陷：拒绝后应停止直到边界 |
| 只读讨论中用户说「开始改」 | 先建 worktree，再编辑；不继续在主工作区写 |
| 用户说「只改一点/很快」 | 仍按写任务建 worktree；不按改动大小例外 |
| 用户明确要求「就在主工作区改」 | 先说明影响，再遵从并记录例外 |
| 准备合并 skills 改动到 main | 默认先确认 CI / pre-push + 做 skill-audit；同一批只跑一次 |
| 用户说「这次跳过 skills 自检」 | 不做默认检查；记录“未审计”，不得声称通过 |
| 未跑检查直接合并 skills main | 视为漏检查；补跑并报告，不默认通过 |
| 连续多轮无新证据 | 停止循环，升级为阻塞或换策略 |

## 使用方式

1. 新会话逐条输入，记录实际加载的 skill。
2. 期望与实际不符：先检查 `description` 的触发词与「不适用」是否明确，再补边界。
3. 同一条连续误触发多次：考虑拆分 skill 或调整 `description` 首句关键词。
4. 多轮场景按「多轮行为与干预策略」模拟：提示 → 接受/拒绝 → 下一边界。
