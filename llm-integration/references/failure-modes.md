# LLM 调用故障速查

> 症状 → 可能原因 → 检查 → 修法。示例中的字段名按 OpenAI 兼容接口；其他 provider 可能不同。

| 症状 | 可能原因 | 检查 | 修法 |
|---|---|---|---|
| `content` 为空，`reasoning_content` 很长 | 模型在 thinking；max_tokens 被推理吃光 | `finish_reason`、reasoning token 数 | 换非 thinking 变体；或给足 max_tokens/timeout；不要只调 temperature |
| `finish_reason=length`，JSON 被截断 | max_tokens 太小；thinking 占满 | usage 的 completion/reasoning 比例 | 增大 max_tokens；缩短 prompt；关闭 thinking |
| HTTP 200，但响应体不是 JSON | 传输/分块/压缩/代理问题；流式未关闭 | 状态码、字节数、前 300 字符；`stream` 是否为 false | 用非流式；换可靠客户端；记录原始响应 |
| schema 已给，仍返回非法 JSON | provider 忽略 schema；模型能力不足 | 直接探测同一 schema | 修复重试一次；仍失败则 fallback；换模型 |
| 返回了合法 JSON，但动作 id 不存在 | enum 与业务候选不同源；旧缓存 | 对比 schema enum 与当前允许集合 | schema 从允许集合生成；解析后再次校验 |
| 超时后 fallback，但稍后又有响应 | 取消与回调竞态 | 日志时间线；是否重复计数 | 超时先标记结束，再取消；迟到响应直接丢弃 |
| 一次失败导致 fallback 计数翻倍 | 同步请求失败又触发了异步回调 | 失败路径数量 | 同步失败只返回值，不再发完成事件 |
| 同一 seed 重跑，JSONL 行数翻倍 | 输出目录复用且追加写 | 文件行数 vs 决策数 | 每次运行前清空本次产物；或每次用新目录 |
| WebSocket 收不到包 / 发错 peer | 传输层包路由问题；单客户端未限制 | 发送者 id、包计数、连接状态 | 用可靠的 TCP+WebSocket 服务；单客户端；发送前校验鉴权 |
| 选了 profile，实际跑了另一个模型 | 未知 profile 静默回退默认值 | 启动日志的 profile id | 未知 profile 启动前失败；不要静默回退 |
| 模型不可用，整局卡住 | 没有超时/降级 | `/v1/models`、加载状态 | 启动前探测；失败则整局规则 fallback |
| 回放结果与录制不一致，但没人发现 | hash 失配被静默忽略 | divergence/stale 字段 | 严格模式停；宽松模式标记 stale，不参与对比 |
| 第一次请求特别慢 | 冷启动 / 模型加载 / prompt cache 未命中 | 冷/热两次延迟 | 用 warm 延迟做选型；冷启动不计入 p95 |
| `reasoning_effort=none` 看似生效，换 prompt 又思考 | 参数只是软提示；provider 实现不一致 | 不同 prompt 的 reasoning token | 不依赖单一开关；按最坏情况给预算或换模型 |

## 通用排查顺序

1. 端点是否可达、模型是否加载
2. 直接用真实 schema 探测，不经过业务代码
3. 看 content、reasoning、finish_reason、usage
4. 再看适配层的解析、校验、重试、fallback
5. 最后看业务状态与回放

先怀疑模型行为，再怀疑业务代码；但不要把「模型能返回」当成「业务接线正确」。
