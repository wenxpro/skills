# LLM 集成偏好（示例，可替换）

> 本文件是偏好层：运行时、模型档、预算与记录路径。通用流程见 `SKILL.md`；换项目时整体替换，不影响通用层。

## 运行时

- 当前使用 LM Studio（应用名 `Bionic`）+ OpenAI 兼容端点：`http://127.0.0.1:1234/v1`。
- AMD RDNA1（如 RX 5700 XT，8 GB）使用 **Vulkan** runtime；ROCm 不支持 `gfx1010`。
- 一次只驻留一个模型；会话开始时 pin 模型 id，中途不切换。
- 单客户端、单飞行；不把决策请求并发化。

## 模型档示例

| profile id | 模型 | Q4 大小 | 实测 | 用途 |
|---|---|---|---|---|
| `local-qwen3-4b-2507` | Qwen3-4B-Instruct-2507 | 2.33 GB | 0.76–0.79 s/次 | 高频主力；非 thinking |
| `local-gemma4-e4b` | Gemma 4 E4B | 4.64 GB | 0.6–12.1 s/次 | 低频对照；thinking 不能可靠关闭，需 20 s 预算 |
| `local-ministral3-3b` | Ministral 3 3B Instruct | 2.00 GB | 待测 | 新一档高频候选；非 thinking |
| `rule-bot` | 无模型 | — | 毫秒级 | 基线、CI、fallback |

> 以上是当前机器的示例，不作为通用推荐。换硬件/任务时重新测。

## 探测请求示例（PowerShell）

```powershell
$body = @{
  model = "<model-id>"
  messages = @(
    @{ role = "system"; content = "Return only the JSON object required by the schema." },
    @{ role = "user"; content = "<realistic decision prompt with allowed options>" }
  )
  response_format = @{
    type = "json_schema"
    json_schema = @{
      name = "action"
      strict = $true
      schema = @{
        type = "object"
        properties = @{ option_id = @{ type = "string"; enum = @("<id-a>", "<id-b>") } }
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

## 预算

| 场景 | timeout | max_tokens | retries |
|---|---|---|---|
| 高频、非 thinking | 8 s | 96–128 | 1 |
| thinking 模型 | 20 s | 768 | 1 |
| 单局总时长 | 10 min | — | — |

- 单次决策超时：先标记结束，再取消请求；迟到响应丢弃。
- 重试只用于修复坏 JSON / schema / 非法动作；超时不重试，直接 fallback。
- fallback 必须是确定性的规则策略，并在报告里单独计数。

## 记录

一次运行一个目录：

```text
artifacts/playtest/<run_id>/
├─ run_manifest.json
├─ decisions.jsonl
├─ report.json
└─ responses.jsonl   # 可选
```

`decisions.jsonl` 每行至少包含：`decision_id`、`seq`、`kind`、`obs_hash`、`prompt_hash`、`schema_hash`、`provenance`、`action`、`validation`、`attempts`、`fallback`、`source`、`latency_ms`、`finish_reason`、`usage`。

## 下载与校验

- Hugging Face 直连不稳定时用镜像：`https://hf-mirror.com/<owner>/<repo>/resolve/main/<file>`。
- 下载后校验 SHA256；LM Studio 模型目录结构必须严格：

```text
<LM Studio models>/<publisher>/<repo>/<file>.gguf
```

- 纯文本决策不需要 `mmproj`；视觉输入再补。
- `lms ls` / `lms ps` 确认模型 id 与加载状态；`lms load <id> --gpu max -c <ctx> -y`。

## thinking 处理

- 不同 provider/模型的开关不一致；不要假设 `enable_thinking=false`、`/no_think`、`reasoning_effort=none` 一定生效。
- 先看响应里的 `reasoning_content` / reasoning token；若 content 为空且 finish=length，按 thinking 处理。
- 可靠做法：换非 thinking 的 instruct 变体；不能换时给足 max_tokens 和 timeout，并接受更高延迟。
