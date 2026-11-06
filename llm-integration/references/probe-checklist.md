# 端点探测清单

> 目标：在写业务适配层之前，确认模型能否稳定产出合法动作。任何一项不通过，先解决模型/参数，不要接线。

## 前置

- 服务已启动，模型已加载；记录准确的 model id、量化、上下文长度、runtime。
- 确认端点只绑定 loopback；不要在探测阶段暴露到局域网。
- 准备一条真实决策 prompt：包含当前状态、候选 id、允许集合。

## 步骤

1. **列模型**：`GET /v1/models`，确认 model id 与预期一致。
2. **冷启动请求**：用真实 prompt + `json_schema` 发一次；记录延迟。
3. **warm 请求**：同一请求再发 2–4 次；记录 p50/p95。
4. **检查 content**：必须是非空字符串，且能解析为 JSON 对象。
5. **检查 reasoning**：`reasoning_content` 是否为空；`usage.completion_tokens_details.reasoning_tokens` 是否接近 max_tokens。
6. **检查 finish_reason**：`length` 表示被截断，不能当作成功。
7. **检查枚举**：返回的 id 必须在允许集合内。
8. **检查响应体**：HTTP 200 不等于 JSON；响应体不是 JSON 时记录状态码、字节数、前 300 字符。
9. **记录**：model id、quant、context、temperature、max_tokens、prompt_hash、schema_hash、延迟、usage、finish_reason。

## 判定

| 现象 | 判定 |
|---|---|
| content 非空、JSON 合法、id 在 enum、finish=stop | 通过 |
| content 为空、只有 reasoning | 不通过；thinking 或截断 |
| finish=length | 不通过；增加预算或关闭 thinking |
| 响应体不是 JSON | 不通过；先查传输/协议 |
| id 不在 enum | 不通过；schema 或候选不同源 |
| warm 延迟超出任务预算 | 不通过；换更小/非 thinking 模型 |

## 最小请求（curl）

```bash
curl -s http://127.0.0.1:1234/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{
    "model": "<model-id>",
    "messages": [
      {"role": "system", "content": "Return only the JSON object required by the schema."},
      {"role": "user", "content": "<realistic decision prompt>"}
    ],
    "response_format": {
      "type": "json_schema",
      "json_schema": {
        "name": "action",
        "strict": true,
        "schema": {
          "type": "object",
          "properties": {"option_id": {"type": "string", "enum": ["<id-a>", "<id-b>"]}},
          "required": ["option_id"],
          "additionalProperties": false
        }
      }
    },
    "temperature": 0,
    "max_tokens": 96
  }'
```

## 探测后只做一件事

把结果写进模型档：id、能力、预算、实测延迟。不要凭记忆在业务代码里写模型名或参数。
