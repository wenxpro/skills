# 上下文地图模板

## 1. 现状

- 项目/模块：
- 入口/组合根：
- 当前分层：
- 主要耦合点：

## 2. 上下文

| 上下文 | 拥有 | 不拥有 |
|---|---|---|
| Run |  |  |
| Combat |  |  |
| Progression |  |  |
| Presentation |  |  |
| Content/Infra |  |  |

## 3. 依赖方向

```text
Presentation → Application → Domain → Shared
Application → Content/Infra
Domain ↛ Presentation
```

允许：

-

禁止：

-

## 4. 共享内核

| 共享对象 | 为什么共享 | 谁维护 |
|---|---|---|
|  |  |  |

## 5. 边界违规

| 违规 | 级别 | 影响 | 修正 |
|---|---|---|---|
|  | High/Medium/Low |  |  |

## 6. 第一个修正

- 范围：
- 不做什么：
- 验收/测试：
- 预计工作包：

## 7. 止损

- 需要改变设计结论时停
- 修正超过 5 个文件仍无法独立测试时停
- 需要不可逆操作时停
