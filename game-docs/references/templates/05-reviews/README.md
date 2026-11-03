# 05 · 评审记录

> 评审流程由 `review` skill 提供；游戏项目使用 `review/profiles/game.md`。
> 记录模板：`review/templates/review.md`；索引模板：`review/templates/review-index.md`。

## 目录约定

```text
05-reviews/
├─ README.md        # active / archive 索引（用 review 的索引模板）
├─ 0001-日期-主题.md
└─ archive/
   └─ 0001-...md    # Superseded / Archived
```

- 每次评审一个文件；active 只保留仍影响当前版本的评审。
- 被取代的评审移入 `archive/`，顶部标 `Superseded`。
- 归档记录可压缩成 1 页摘要，原文留在 git 历史。
