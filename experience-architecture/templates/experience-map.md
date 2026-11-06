# Experience Map — <product / milestone>

> 一页图；只写表面、导航、状态、生命周期、延后项，不写视觉细节。

## 1. 表面清单

| Surface | Type | Entry | Exit / Back | Owner | Status |
|---|---|---|---|---|---|
|  | Screen / Overlay / Mode / System |  |  |  | Current / Deferred |

## 2. 导航拓扑

```text
<Root>
├─ <Category A>
│  ├─ <Detail A1>
│  └─ <Detail A2>
├─ <Category B>
└─ <System / Settings>
```

规则：

- 一个根入口；最多两层。
- 每条边都有返回路径。
- 覆盖层不改变根导航。

## 3. 状态所有权

| State | Owner | Lifetime | Reset on | Persistent? |
|---|---|---|---|---|
| Product state |  |  |  |  |
| Session state |  |  |  |  |
| Run state |  |  |  |  |
| Persistent state |  |  |  |  |

## 4. 生命周期

| Surface / Mode | Create | Load | Activate | Pause | Resume | Teardown |
|---|---|---|---|---|---|---|
|  |  |  |  |  |  |  |

## 5. 输入与焦点

| 表面 | Esc / Back | 焦点进入 | 焦点离开 | 局内输入 |
|---|---|---|---|---|
|  |  |  |  |  |

## 6. 延后项

| Surface | Why deferred | Trigger | Cost | Owner |
|---|---|---|---|---|
|  |  |  |  |  |

> 没有触发条件的延后项 = 遗漏。

## 7. 验收种子

- [ ] 从根入口能到达当前所有表面
- [ ] 每个表面有明确返回路径
- [ ] 模式有 Setup → Run → Result → Retry/Exit
- [ ] 暂停作用域符合预期，菜单不被冻结
- [ ] 重开/退出清理节点、定时器、信号、缓存
- [ ] 固定输入序列可复现导航结果

## 8. 开放问题

| # | 问题 | 当前倾向 | 决定人 |
|---|---|---|---|
|  |  |  |  |
