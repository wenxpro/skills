---
name: llm-integration
description: LLM 调用集成：模型档探测、结构化输出、失败降级、回放与高频选型。适用于把本地或云端 LLM 接入游戏/工具、排查空 content、超时、非法动作、模型切换；不适用于 prompt 文案调优、模型训练/微调、纯 API 单点问答。
---

# LLM 调用集成

把 LLM 接入应用时，大多数故障不在业务代码，而在「模型行为没有先验证」：模型在 thinking、返回空 content、schema 没生效、超时后旧响应才到、fallback 被隐藏。本 skill 的顺序是：**先探测，再选档，再接适配层，最后用失败路径和回放证明它可靠。**

> 个人/团队偏好（运行时命令、模型档示例、延迟预算、记录路径）在 `standards.md`；探测步骤在 `references/probe-checklist.md`；故障速查在 `references/failure-modes.md`；配置模板在 `templates/model-profile.json`。

## 何时使用

- 把本地或云端 LLM 接入游戏、工具、自动化流程
- 需要稳定 JSON / 枚举动作，而不是自由文本
- 遇到空 content、thinking 吃 token、超时、非法动作、模型切换
- 设计高频跑批、fallback、回放与模型对比

不适用：prompt 文案调优；模型训练/微调；provider 账号与计费；只查一个 API 参数怎么用；泛化的模型生态/竞品调研（用 `topic-research`）。

## 核心原则

1. **先探测，再接业务。** 直接请求端点，确认 content、reasoning、finish_reason、延迟，再写适配层。
2. **模型是配置，不是分支。** 用 profile 注册表 + 一个 active profile；代码不按模型名分支。
3. **结构化输出。** schema 的 enum 来自业务允许集合；解析后再次校验；不解析自由文本。
4. **content 与 reasoning 分开。** reasoning 不是答案；content 为空一律按失败处理。
5. **失败必须降级。** 超时、坏 JSON、非法动作、模型不可用 → 确定性 fallback，并在报告里可见。
6. **一次运行一个 profile，provenance 必带。** 记录 profile id/hash、prompt/schema hash、usage、finish_reason、延迟。

## 操作顺序

1. 定义调用面
2. 选模型档
3. 探测端点
4. 接适配层
5. 覆盖失败路径
6. 回放与验证

## 第一步：定义调用面

先写清楚，不写代码：

| 问题 | 产出 |
|---|---|
| 决策点在哪里、多久一次 | 稀疏决策点列表；逐帧请求不适合 LLM |
| 输入是什么、输出必须是什么 | 紧凑状态 + 候选 id；输出只含动作 id |
| 谁最终裁决合法性 | 业务侧是最终权威，适配层只做预校验 |
| 单次和单局延迟预算 | 超时值、重试次数、降级动作 |
| 失败后怎么办 | 确定性 fallback；本局必须能跑完 |
| 记录哪些字段 | 决策、动作、校验结果、usage、延迟、profile |
| 哪些字段不参与对比 | 延迟、token、时间戳、原始响应 |

## 第二步：选模型档

- **高频跑**：优先非 thinking 的 instruct 变体；3B–4B 通常是速度和质量的平衡点。
- **低频内容验证**：可以用 reasoning 模型，但要单独给推理预算。
- **不看名字看实测**：同系列不同版本可能一个 thinking、一个 instruct。
- **显存先算总账**：权重 + 上下文 + KV + 运行时；不要只看文件大小。
- **能力声明**：json_schema、seed、vision、context；启动时校验，不满足就失败，不要静默假设。
- **新模型不等于适合**：先看是否 instruct、是否默认 reasoning、是否有可靠 JSON 输出。

具体的候选模型、量化和延迟记录放 `standards.md`，不写进通用层。

## 第三步：探测端点

用真实 prompt 和真实 schema 直接打端点，不经过业务代码。

检查：

- HTTP 状态与响应体是否是 JSON
- `content` 是否非空
- `reasoning_content` / reasoning token 是否吃掉了输出
- `finish_reason` 是否为 `length`
- 返回的 option 是否在 enum 内
- 冷启动和 warm 各测一次；记录 p50/p95

**通过条件**：content 为空、finish_reason=length、option 非法、响应体不是 JSON，任一出现就不要接线。

详细步骤与请求示例见 `references/probe-checklist.md`。

## 第四步：接适配层

- **profile 注册表**：id、transport、endpoint、model、capabilities、sampling、budget；一个 active profile。
- **未知 profile 或不满足能力**：启动前失败，不静默回退到另一个模型。
- **prompt**：稳定 system 前缀；只放当前决策需要的状态和候选；候选 id 与 schema enum 同源。
- **输出**：只要求一个动作 id；max_tokens 只够 JSON；不要求解释。
- **校验**：解析 → schema → 允许集合 → 业务最终裁决；失败重试一次，修复提示里带错误，不无限重试。
- **传输**：单飞行；请求有超时；超时先标记结束再取消；忽略结束后的迟到响应。
- **记录**：每次决策一行；一次运行一个目录；记录 profile/provenance/usage/finish_reason/延迟；原始响应可选落盘。

配置形状见 `templates/model-profile.json`。

## 第五步：覆盖失败路径

至少覆盖：

| 场景 | 期望 |
|---|---|
| 模型不可用 / 端点不可达 | 启动前或首次请求失败，走整局 fallback，报告可见 |
| 空 content / 只有 reasoning | 不当作成功；按 thinking 或截断处理 |
| finish_reason=length | 增加预算或关闭 thinking；不能静默截断 |
| 非法 JSON / schema 不符 | 修复重试一次，仍失败则 fallback |
| 非法动作 id | 拒绝并记录；不修改业务状态 |
| 超时 + 迟到响应 | 先标记结束再取消；迟到响应丢弃 |
| 同步请求失败与异步回调双处理 | 只保留一条失败路径，避免 fallback 计数翻倍 |
| 断线 / 重连 | 当前决策 fallback；会话降级可见 |
| 同一目录重跑导致 JSONL 追加 | 每次运行前清空本次产物 |
| profile 拼写错误 | 启动前失败，不静默使用默认模型 |

详细症状与修法见 `references/failure-modes.md`。

## 第六步：回放与验证

- 记录动作序列；回放不加载模型，按 `(run_seed, seq, observation_hash)` 匹配。
- 严格模式遇到 hash 不一致立即停；宽松模式继续但标记 divergence/stale。
- 验证矩阵：
  1. 端点探测（真实 schema）
  2. 适配层单元测试（schema/枚举/非法动作）
  3. 完整短局（0 fallback / 0 非法动作）
  4. 失败注入（超时、空 content、模型不可用、断线）
  5. 回放一致性（动作/结果/等级）
  6. 正常模式回归（不启用 LLM 时行为不变）

## 反模式

- 先写业务代码，最后才试模型。
- 按模型名猜能力；把「新」当「适合」。
- 用 reasoning 模型做高频逐帧/高频决策。
- 只检查 HTTP 200，不检查 content 是否为空。
- 用自由文本 + 正则解析动作。
- 重试没有上限，或 fallback 静默发生。
- 超时后取消，却把迟到响应当成新响应。
- 同一输出目录追加记录，重跑后行数翻倍。
- 把 API key、完整端点或原始 prompt 写进报告。
- 服务绑定 `0.0.0.0` 或把模型端点暴露到局域网。

## 主动行为

无主动行为。只在被调用时执行；不打断用户，不主动建议换模型，除非探测结果触发上面的条件。

## 边界

- 不训练、不微调、不做量化。
- 不写具体 prompt 文案；只规定结构与验证。
- 不处理 provider 账号、计费、配额申请。
- 不替代项目验收；回放通过不等于内容结论成立。

## 交接

- 模块/接口设计：`design-stage` / `responsibility-design`
- 实现执行：`execution-loop` / `delivery-stage`
- 合并前检查：`code-review`
- 选型调研：`topic-research`
- 验收状态：`implementation-track`
