# 触发回归清单

改过任何 skill 的 `description` 后，用这些句子验证触发是否正确。

## 规划与执行

| 输入 | 期望触发 | 不应触发 |
|---|---|---|
| 「接下来做什么？V1 和 V2 怎么拆」 | roadmap-planning | execution-loop、implementation-track |
| 「做到 M1 验收全过再汇报，别每步问我」 | execution-loop | roadmap-planning |
| 「验收项做到哪了？偏差怎么记」 | implementation-track | execution-loop、roadmap-planning |
| 「评审一下这个方案，能不能过」 | review | docs-audit、code-review |
| 「审一下这次改动有没有坑」 | code-review | review、docs-audit |
| 「合并前该跑哪些验证」 | code-review | execution-loop |
| 「审核一下这套文档，有没有矛盾过时」 | docs-audit | review、code-review |

## 文档与代码

| 输入 | 期望触发 | 不应触发 |
|---|---|---|
| 「给新游戏建一套设计文档」 | game-docs | docs-core、docs-audit |
| 「什么内容该写进哪篇文档」 | docs-core | game-docs |
| 「梳理一下这个项目的演进和模块细节」 | code-digest | responsibility-design、topic-research |
| 「模块边界太乱，先修哪条依赖」 | responsibility-design | code-digest |
| 「调研一下终端 UI 生态」 | topic-research | code-digest |
| 「提交并推送」 | git-commit | execution-loop |
| 「审一下 skills 仓库的抽象分层」 | skill-audit | docs-audit |
| 「检查一下 skills 仓库的术语是否统一」 | skill-audit | docs-audit |
| 「检查一下文档里的术语是否统一」 | docs-audit | skill-audit |

## 使用方式

1. 新会话逐条输入，记录实际加载的 skill。
2. 期望与实际不符：先检查 `description` 的触发词与「不适用」是否明确，再补边界。
3. 同一条连续误触发多次：考虑拆分 skill 或调整 `description` 首句关键词。
