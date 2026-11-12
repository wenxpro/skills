# Workflow — 多角色评审

## 1. 定义决策问题

先用一句话写清楚：

> 这次评审要决定什么？

不合格：

- 「看看这个方案怎么样」
- 「大家提提意见」

合格：

- 「是否采用 X 方案，目标指标是多少？」
- 「是否把 Y 配置迁入单文件？」
- 「是否允许当前架构进入下一阶段？」

## 2. 选择 profile

| 场景 | Profile |
|---|---|
| 游戏玩法/里程碑 | `profiles/game.md` |
| 软件产品/API/平台 | `profiles/software.md` |
| 文档体系/规范 | `profiles/docs.md` |
| 架构/基础设施/上线 | `profiles/architecture.md` |

不要用 A 领域的角色评审 B 领域的方案。

## 3. 准备证据包

至少：

- 评审对象（Spec / RFC / ADR / 文档）
- 约束（时间、范围、非目标）
- 已有数据（测试、试用/用户测试、监控、性能）
- 需要拍板的问题清单

没有证据的议题，标「待补证据」，不要假装通过。

## 4. 自检

- 文档链接可解析
- 版本/日期一致
- 范围只覆盖当前里程碑
- 没有把废案写进当前约束

## 5. 跑角色

按 profile 的角色逐个给出：

- 认可
- 条件
- 否决理由（如有）

每个角色只写 1~3 条关键意见，不写长篇。

## 6. 形成结论

- 全部认可 → `通过`
- 有条件但方向成立 → `有条件通过`
- 关键角色否决且无法降级 → `否决`
- 方案被后续决策取代 → `Superseded`

## 7. 写行动项

每条必须有：

```text
ID | 条件/行动 | 负责人 | 写入位置 | 截止
```

没有负责人/截止的条件，视为未完成评审。

## 8. 写记录

使用 `templates/review.md`，控制在 1~2 页。

## 9. 更新索引

- active 评审写入评审目录的 README 索引（game profile 为 `05-reviews/README.md`；software profile 按项目约定）
- 被取代的评审移入 `archive/`，标 `Superseded`
- 关闭的条件从 active 行动项里移除或标完成

## 10. 检查

```powershell
# game profile 路径示例；其他 profile 换成项目的评审目录
.\scripts\check-review.ps1 -ReviewPath "<target>\docs\05-reviews"
```

## 完成标准

- 决策问题明确
- 角色齐全
- 结论明确
- 条件有负责人/截止
- 证据链接可解析
- active/archive 已更新
- 检查通过
