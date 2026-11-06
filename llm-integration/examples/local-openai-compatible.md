# 示例：LM Studio / OpenAI 兼容端点

> **示例层，不属于通用规则。** 换机器、换运行时、换供应商时整份替换；不要把这里的模型名、端口、字段名或延迟写回 `SKILL.md` / `standards.md`。

## 环境

- 运行时：LM Studio（应用名 `Bionic`），OpenAI 兼容端点 `http://127.0.0.1:1234/v1`。
- 显卡：AMD RX 5700 XT（RDNA1，8 GB）。用 **Vulkan** runtime；ROCm 不支持 `gfx1010`。
- 一次只驻留一个模型；单客户端、单飞行。

## 模型档示例

| profile id | 模型标识 | Q4 大小 | 实测 | 备注 |
|---|---|---|---|---|
| `local-qwen3-4b-2507` | `qwen3-4b-instruct-2507` | 2.33 GB | 0.76–0.79 s/次 | 高频主力；非 thinking |
| `local-gemma4-e4b` | `gemma-4-e4b-it` | 4.64 GB | 0.6–12.1 s/次 | 低频对照；thinking 不能可靠关闭 |
| `local-ministral3-3b` | `Ministral-3-3B-Instruct-2512` | 2.00 GB | 待测 | 新一档高频候选；非 thinking |
| `rule-bot` | 无模型 | — | 毫秒级 | 基线、CI、降级 |

## 运行时命令

```powershell
$lms = "$env:USERPROFILE\.lmstudio\bin\lms.exe"
& $lms status
& $lms ls
& $lms ps
& $lms unload <model-id>
& $lms load <model-id> --gpu max -c 4096 -y
```

模型目录结构：

```text
<LM Studio models>/<publisher>/<repo>/<file>.gguf
```

纯文本决策不需要 `mmproj`；视觉输入再补。下载后校验 SHA256；Hugging Face 直连不稳定时用 `hf-mirror.com`。

## 探测请求（PowerShell）

```powershell
$body = @{
  model = "qwen3-4b-instruct-2507"
  messages = @(
    @{ role = "system"; content = "Return only the JSON object required by the schema." },
    @{ role = "user"; content = "HP low; choose damage or armor." }
  )
  response_format = @{
    type = "json_schema"
    json_schema = @{
      name = "action"
      strict = $true
      schema = @{
        type = "object"
        properties = @{ option_id = @{ type = "string"; enum = @("damage", "armor") } }
        required = @("option_id")
        additionalProperties = $false
      }
    }
  }
  temperature = 0
  max_tokens = 96
}
$sw = [System.Diagnostics.Stopwatch]::StartNew()
$r = Invoke-RestMethod -Uri "http://127.0.0.1:1234/v1/chat/completions" `
  -Method Post -ContentType "application/json" -Body ($body | ConvertTo-Json -Depth 10) -TimeoutSec 60
$sw.Stop()
"latency_ms=$($sw.ElapsedMilliseconds)"
"content=[$($r.choices[0].message.content)]"
"reasoning=[$($r.choices[0].message.reasoning_content)]"
"finish=$($r.choices[0].finish_reason) usage=$($r.usage.prompt_tokens)+$($r.usage.completion_tokens)"
```

字段映射：

| 通用概念 | OpenAI 兼容字段 |
|---|---|
| 最终答案 | `choices[0].message.content` |
| 推理过程 | `choices[0].message.reasoning_content` |
| 结束原因 | `choices[0].finish_reason` |
| 输出预算 | `max_tokens` |
| 受约束输出 | `response_format.json_schema` |
| 推理开关 | `reasoning_effort`、`enable_thinking`、`/no_think`（实现不一致） |

## 预算示例

| 场景 | timeout | max_tokens | retries |
|---|---|---|---|
| 高频、非 thinking | 8 s | 96–128 | 1 |
| thinking 模型 | 20 s | 768 | 1 |

## 记录示例

```text
artifacts/playtest/<run_id>/
├─ run_manifest.json
├─ decisions.jsonl
├─ report.json
└─ responses.jsonl   # 可选
```

`decisions.jsonl` 字段示例：`decision_id`、`seq`、`kind`、`obs_hash`、`prompt_hash`、`schema_hash`、`provenance`、`action`、`validation`、`attempts`、`fallback`、`source`、`latency_ms`、`finish_reason`、`usage`。

## 这个环境踩过的坑

- Qwen3.5 / Gemma 4 默认 thinking；`content` 为空、只有 `reasoning_content`。`enable_thinking=false`、`chat_template_kwargs`、`/no_think` 在 LM Studio 0.4.17 下都不可靠；`reasoning_effort=none` 只对部分输入生效。可靠做法是换非 thinking 的 instruct 变体，或给足 `max_tokens`/`timeout`。
- `HTTPRequest` 在节点还没进入场景树时调用会返回 `ERR_UNCONFIGURED`；先等一帧。
- 超时先标记结束再 `cancel()`，否则取消回调可能被当成新响应。
- 同步请求失败不要再 emit 完成事件，否则降级计数翻倍。
- 同一输出目录复用会追加 JSONL；每次运行前清空本次产物。
- `WebSocketMultiplayerPeer` 的包路由在本地服务端场景不稳定；改用 `TCPServer + WebSocketPeer.accept_stream`。
- profile 拼写错误不得静默回退默认模型；启动前失败。
