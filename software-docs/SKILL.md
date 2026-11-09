---
name: software-docs
description: 软件项目文档体系与模板：PRD、架构、接口、数据、安全、运行手册、验收、ADR 与证据；槽位规则见 docs-core。适用于新软件项目立项、重构设计文档、定义验收、准备设计评审与交接；不适用于游戏文档（game-docs）、具体接口/数据/安全设计方法（backend-design）、UI 规范（ui-baseline）、纯代码修复、文档集审核（docs-audit）、排期（roadmap-planning）、验收跟踪（implementation-track）。
---

# Software Docs

建立和维护软件项目文档。槽位模型、单一事实源、状态语义、变更三件套见 `docs-core`；本 skill 只定义软件项目的文件映射、模板与写作顺序。

## 何时使用

- 新软件项目 / 新服务 / 新模块，需要从需求走到可验收
- 现有项目只有 README 和零散设计，需要收敛成文档集
- 准备设计评审、跨团队交接、上线评审
- 需要把行为规则和验收用例对上
- 需要补 ADR、接口、数据、安全或运行手册

不适用：

- 游戏项目 → `game-docs`
- 纯代码修复、重构、性能优化 → `delivery-stage` / `code-review`
- 单个方法或页面排版问答
- 文档集一致性审核 → `docs-audit`
- 跨版本排期 → `roadmap-planning`
- 验收状态推进 → `implementation-track`

## 核心规则

1. **一个事实一个槽位。** 行为在规则，验收在验收，证据在证据；其他文档只引用。
2. **先短后长。** 先写一页 PRD 和架构边界；接口、数据、安全、运行手册只在项目实际需要时展开，不写空模板。
3. **规则可判定。** 每条 P0 规则能映射到至少一个 `AC-*`；无法判定的规则先改写成可观察行为。
4. **验收有证据。** 每条 `AC-*` 指定证据类型；没有证据只能标「待补证据」，不能算通过。
5. **写进目标项目。** 文档写到项目的 `docs/`，不写进 skill 目录；模板只提供结构。
6. **不猜项目事实。** 用户、SLO、数据量、合规要求、技术栈必须来自项目输入；缺就问。
7. **垂直内容交给垂直 skill。** UI 基线用 `ui-baseline`；后端/接口/数据/安全/可靠性方法用 `backend-design`；跨仓库接口登记用 `cross-project-integration`。

## 主动行为

本 skill 为参考型，不主动打断或提示；用户请求建立/重构软件文档时按流程执行。信息不足时先问缺失项，不猜项目事实。

## 文档映射

槽位定义见 `docs-core`；软件项目默认文件如下。小项目可裁剪，但槽位职责不能混。

| 槽位 | 文件 | 说明 |
|---|---|---|
| 入口 | `docs/00-README.md` | 索引、状态、阅读顺序、当前里程碑 |
| 假设 | `docs/01-PRD.md` | 问题、用户、范围、非目标、成功指标、约束 |
| 规则 | `docs/02-ARCHITECTURE.md` | 上下文、容器、组件、部署、依赖、故障域 |
| 规则 | `docs/03-INTERFACE.md` | 对外/对内接口约定、错误、幂等、版本、鉴权 |
| 规则 | `docs/04-DATA.md` | 数据所有权、schema、索引、一致性、迁移、保留、PII |
| 规则 | `docs/05-SECURITY.md` | 资产、角色、信任边界、威胁模型、认证授权、密钥 |
| 规则 | `docs/06-RUNBOOK.md` | SLO、告警、发布/回滚、备份恢复、故障处理 |
| 验收 | `docs/07-ACCEPTANCE.md` | `AC-*` 矩阵、证据、DoD、状态 |
| 决策 | `docs/08-adr/` | 不可逆或跨版本决策；一页一个决策 |
| 证据 | `docs/09-reviews/` | 设计评审、代码审查、上线评审记录 |
| 证据 | `docs/10-evidence/` | 测试报告、基准、威胁模型确认、迁移演练、截图 |

裁剪规则：

- 单机小工具：`00 / 01 / 07` 足够；有不可逆决定再加 ADR。
- 有服务端或数据库：补 `02 / 03 / 04`。
- 涉及账号、支付、PII、对外接口：补 `05`；上线前补 `06`。
- UI 项目：在 `02-ARCHITECTURE.md` 引用 `docs/UI-SPEC.md`，不把视觉规范塞进架构文档。
- 跨团队/跨仓库：接口登记另用 `cross-project-integration` 的表，`03-INTERFACE.md` 只保留本项目视角。

## 写作顺序

1. **界定**：写 `01-PRD.md` 的问题、用户、范围、非目标、约束；明确不做什么。
2. **边界**：写 `02-ARCHITECTURE.md` 的上下文、容器、依赖方向、部署与故障域；不可逆决定记 ADR。
3. **接口与数据**：按需写 `03-INTERFACE.md` 和 `04-DATA.md`；先定所有权，再定字段。
4. **安全与运行**：按需写 `05-SECURITY.md` 和 `06-RUNBOOK.md`；高风险项先做威胁模型。
5. **验收**：写 `07-ACCEPTANCE.md`，按 `docs-core/references/acceptance-taxonomy.md` 分类并指定证据。
6. **评审**：用 `review` 的 `profiles/software.md`；高风险追加安全/数据/SRE 角色。
7. **交付**：交 `delivery-stage`；状态由 `implementation-track` 更新；证据回填 `10-evidence/`。

## 验收与证据

- 验收类别：功能、UI、无障碍、安全、性能、可靠性、数据、兼容、合规、运维。
- 证据阶梯：静态检查 → 单元测试 → 集成/接口测试 → 端到端/真机 → 线上观察。
- 规则：`SKIP` 不等于通过；`N/A` 必须写原因和批准人；非功能项没有证据只能「有条件通过」。
- 详细定义见 `docs-core/references/acceptance-taxonomy.md`。

## ADR 规则

- 一个 ADR 只回答一个决策；写背景、备选、取舍、结论、后果、复审触发。
- 不可逆决定（数据格式、公开接口、认证方式、供应商锁定）必须记 ADR。
- 已实现但仍约束当前行为的 ADR 保持 active；被替代时标 `Superseded` 并链接新 ADR。
- 模板见 `references/templates/adr.md`；复制为 `docs/08-adr/NNNN-<slug>.md`。

## 检查表

- [ ] `00-README` 能让人快速知道项目做什么、当前状态、下一步
- [ ] PRD 有范围、非目标、成功指标和约束
- [ ] 架构有上下文、容器、依赖方向、部署与故障域
- [ ] 接口有错误、幂等、版本、鉴权、限流约定
- [ ] 数据有所有权、schema、索引、一致性、迁移、保留、PII
- [ ] 安全有资产、角色、信任边界、威胁与缓解
- [ ] 运行手册有 SLO、告警、回滚、备份恢复
- [ ] 每条 P0 规则有 `AC-*`，每条 `AC-*` 有证据类型
- [ ] 不可逆决定有 ADR
- [ ] 评审记录与证据已链接，不复制正文

## 边界与交接

- 文档结构规则：`docs-core`
- 游戏文档：`game-docs`
- 后端/接口/数据/安全/可靠性设计：`backend-design`
- UI 基线：`ui-baseline`
- 设计阶段：`design-stage`
- 评审：`review`
- 排期：`roadmap-planning`
- 交付：`delivery-stage` / `execution-loop`
- 验收状态：`implementation-track`
- 跨仓库接口：`cross-project-integration`

## 反模式

- 只有 README，没有 PRD/验收/证据，靠口头约定
- 把模板当项目内容，留一堆占位符
- 同一规则在 PRD、架构、验收各写一遍，改一处漏两处
- 接口、数据、安全只写「后续补充」
- 验收只写功能，不写非功能与证据
- 用 ADR 记录普通实现细节
- 把视觉规范塞进架构文档
