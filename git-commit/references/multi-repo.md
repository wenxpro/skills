# 多仓库提交

> 本文件是 `git-commit` 的多仓库模式；通用提交规则、message 格式与单仓库流程见 [SKILL.md](../SKILL.md) 和 [standards.md](../standards.md)。

## 1. 预检

先列出所有涉及仓库：

| 仓库 | 路径 | 分支 | remote | 工作区 | owner |
|---|---|---|---|---|---|
| A | `<repo-a>` | `main` | `<remote-a>` | clean / dirty | 谁负责 |
| B | `<repo-b>` | `main` | `<remote-b>` | clean / dirty | 谁负责 |

每个仓库至少检查：

```bash
git -C <repo> status --short --branch
git -C <repo> remote -v
git -C <repo> branch --show-current
git -C <repo> log --oneline -1
```

不同域名/凭据时，先验证认证：

```bash
ssh -T git@<host>
```

或确认该仓库的 credential helper 可用。

## 2. 分组与排序

- 按仓库分组，不按时间或文件类型跨仓库混提交。
- 一个仓库内可以按性质拆多个提交。
- 跨仓库有依赖时，按依赖顺序：
  - 被依赖的仓库或规范仓库先提交。
  - 使用方仓库后提交。
  - 描述行为的文档跟随代码仓库，或紧接其后。
- 只暂存本次任务的文件；工作区有用户未提交内容时，不默认 `git add -A`。
- 无法判断某个文件是否属于本次任务时，先问用户。

## 3. 逐仓库提交

对每个仓库执行：

1. **看变更**：`git -C <repo> diff -- <paths>`、`git -C <repo> diff --cached`。
2. **暂存明确路径**：`git -C <repo> add <paths>`。
3. **提交**：按 `standards.md` 的 message 规范。
4. **记录 hash**：`git -C <repo> rev-parse HEAD`。
5. **推送**：`git -C <repo> push origin <branch>`。
6. **验证远端**：`git -C <repo> ls-remote origin <branch>`。
7. **记录状态**：clean / 仍有用户改动 / 推送失败。

不要用一条命令跨仓库提交；每个仓库单独执行。

## 4. 部分失败

多仓库推送不是原子的，失败是正常状态：

- 一个仓库成功、另一个失败时，不要声称“全部已推送”。
- 只重试失败的仓库；已成功的不要重复提交。
- 网络/认证失败和代码/测试失败分开记录。
- 不用 force push、不重写历史来“修复”部分失败。
- 推送成功后仍有用户未提交文件，要明确标注“未包含在本次提交”。

## 5. 跨仓库一致性

- 同一个任务/issue/ADR 的编号写进各仓库 commit message。
- 仓库 A 依赖仓库 B 的版本时，在总结里记录 B 的 commit hash。
- 代码仓库与文档仓库同时变更时，确保文档引用的是本次代码提交，而不是旧版本。
- 同一个变更不要在两个仓库重复实现；指定唯一 owner。
- 提交前确认接口登记表版本一致；只提交一侧会让下游失效。
- 一个仓库的变更会让另一个仓库失效时，停下来报告，不要继续推。

## 6. 提交顺序偏好

默认按依赖排序：

1. 共享库 / 规范 / schema。
2. 使用方代码。
3. 文档 / 示例 / 变更记录。

如果文档描述的是本次代码行为，文档可以跟随代码仓库，或紧接其后提交。

## 7. 凭据

- 不同域名优先用 SSH key，按 host 配置。
- HTTPS 使用 credential helper；不要把 token 写进 remote URL。
- 一个任务内可以顺序推送多个仓库，但每个仓库使用自己的 remote/凭据。
- 认证失败先验证 `ssh -T <host>` 或 credential helper，不要盲目重试。

## 8. 汇报格式

至少给出：

| 仓库 | 分支 | commit | push | 远端验证 | 备注 |
|---|---|---|---|---|---|
| A | `main` | `<hash>` | 成功/失败 | `ls-remote` 一致 | 未提交文件 |
| B | `main` | `<hash>` | 成功/失败 | `ls-remote` 一致 | 部分失败重试 |

补充：

1. 哪些文件没有提交、为什么。
2. 失败仓库的重试命令。
3. 跨仓库依赖与版本。
4. 下一步。

## 9. 反模式

- 把多个仓库当成一个原子提交。
- 一次 `git add -A` 扫过多个仓库。
- 推成功一个仓库就汇报“全部完成”。
- 把用户未提交的工作混进本次提交。
- 不同域名共用同一套凭据，失败后反复重试。
- 用 force push 处理部分失败。
- 不验证远端就宣布推送成功。
- 文档和代码同时改，却不互相引用。
