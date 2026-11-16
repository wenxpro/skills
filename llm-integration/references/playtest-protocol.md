# LLM 试玩协议与评估

> 适用于「游戏产生稀疏决策点，外部 LLM 选择动作」的试玩。模型/端点由项目配置，不写进协议。

## 1. 边界

- 游戏拥有：何时产生决策点、观察投影、候选枚举、最终合法性、动作应用、内容指标、确定性 fallback。
- 核心拥有：协议信封、decision_id/obs_hash、prompt 组装机制、输出 schema、模型传输、单飞行、重试、fallback、记录、回放、评估、报告。
- 不拥有：玩法规则、平衡、实时战斗控制、云 key。

## 2. 观察/动作

| 字段 | 要定义 |
|---|---|
| run_id / seq | 会话与序号 |
| game_time / locale | 时间与语言 |
| state | 观察投影（只给决策所需） |
| options | 候选动作 |
| constraints | allowed_ids/上限 |
| fallback_option_id | 模型失败时的确定性选择 |
| action | decision_id + option_id |
| action_result | ok/error/message |

要求：

- options 与 constraints 一致；非法 context 不参与合法率。
- 观察不泄漏隐藏信息。
- 动作合法性由游戏最终判定。
- fallback 必须确定性、可解释。

## 3. 会话

- 单飞行：同一决策点不并发请求。
- 重试：次数/退避/超时。
- fallback：模型错误/超时/空输出都有记录。
- 记录：请求/响应/耗时/错误/选择。
- 回放：不加载模型也能重放决策。

## 4. 评估

| 层 | 目的 |
|---|---|
| L1 回放 | 同一记录可复现 |
| L2 多 profile | 不同模型/配置对比 |
| L3 对照 | 规则 bot / 人类基线 |
| 内容指标 | 胜率、时长、构筑/覆盖率 |
| 协议指标 | 合法率、超时、fallback、覆盖率 |

要求：

- 报告写清模型、seed、上下文、样本量。
- 不用 LLM 结果替代真人试玩。
- 失败/超时/非法动作保留原始记录。
- 结论分层：协议正确、内容有效、体验好玩是三件事。

## 5. 一致性

- 协议 schema/哈希在客户端与服务端一致。
- 最小第二消费者做 conformance。
- 跨语言/跨版本用固定 fixture。
- 记录 provenance：模型、prompt 版本、代码 commit。
