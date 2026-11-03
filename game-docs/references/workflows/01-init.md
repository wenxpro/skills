# Workflow 01 — 初始化项目文档

## 何时使用

- 新游戏项目，需要从零建立文档
- 已有项目，但文档是散的 / 过时的 / 不可验收的
- 需要一套可交给 `review` skill（game profile）评审的规范

## 输入

先问，不要猜：

| 输入 | 说明 |
|---|---|
| 目标路径 | 项目根目录，例如 `<target>` |
| 项目名 | 用于标题和占位符 |
| 类型 | Roguelite / 平台跳跃 / 解谜 / 其他 |
| 核心动词 | 只能一个，例如 `move + auto attack` |
| 当前里程碑 | 默认 `M0 立项` |

## 步骤

1. **检查目标目录**
   - 如果 `docs/` 已存在且非空：先读 `00-README.md`，问用户是覆盖、合并还是换目录。
   - 不要默认使用 `-Force`。

2. **生成骨架**

   ```powershell
   .\scripts\new-project-docs.ps1 `
     -Target "<target>" `
     -ProjectName "<name>" `
     -Genre "<genre>" `
     -CoreVerb "<core verb>" `
     -Milestone "<milestone>"
   ```

3. **填 01 单局简报**
   - 读 `references/templates/01-run-brief.md`。
   - 一次只填一页：一句话、单局参数、核心循环、灰盒范围、验证问题、止损条件。
   - 不写未来内容；未来内容放「后置内容」。

4. **写 ADR-0001（如需要）**
   - 如果「做什么类型 / 核心动词」不是显而易见的选择，用 `references/templates/04-adr/0000-adr-template.md` 写 `04-adr/0001-core-verb.md`。
   - 必须写：备选方案、对比、反方意见、止损条件。

5. **自检**

   ```powershell
   .\scripts\check-docs.ps1 -DocsPath "<target>\docs"
   ```

6. **停止**
   - 01 没有被用户确认前，不写 02 / 03。
   - 输出：已生成文件、检查结果、待确认问题、下一步（02-spec）。

## 完成标准

- `docs/` 结构完整（00~07）
- 01 一页纸能说清「这一局是什么」
- 关键方向有 ADR（如有必要）
- `check-docs.ps1` 通过

## 常见错误

- 一上来写 20 页 GDD
- 把参考实现的内容抄进新项目
- 替用户决定类型 / 核心动词
- 在 01 里写 8 分钟、Boss、多角色
