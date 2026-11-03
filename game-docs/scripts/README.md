# Scripts

> Windows PowerShell 5.1+。非 Windows 可手动复制 `references/templates/`，或使用 PowerShell 7。

## 1. `new-project-docs.ps1`

把 `references/templates/` 复制到目标项目，并替换占位符。

从 skill 根目录运行：

```powershell
.\scripts\new-project-docs.ps1 `
  -Target "<target>" `
  -ProjectName "<project name>" `
  -Genre "<genre>" `
  -CoreVerb "<core verb>" `
  -Milestone "M0 立项"
```

从 `scripts/` 目录运行：

```powershell
.\new-project-docs.ps1 -Target "<target>"
```

参数：

| 参数 | 默认 | 作用 |
|---|---|---|
| `-Target` | 必填 | 目标项目目录 |
| `-ProjectName` | New Game | 项目名 |
| `-Genre` | Roguelite | 类型 |
| `-CoreVerb` | move + attack | 核心动词 |
| `-Milestone` | M0 立项 | 当前里程碑 |
| `-Force` | 关 | 覆盖已存在的 docs |

> `-Force` 只覆盖模板文件，不会删除目标项目自己新增的文档。覆盖前必须先征得用户同意。

## 2. `check-docs.ps1`

检查：

- 必需文件 / 目录是否存在（00~07）
- 根文档是否有 `NN-` 编号
- 本地 Markdown 链接是否可解析
- 是否残留占位符

```powershell
.\scripts\check-docs.ps1 -DocsPath "<target>\docs"
```

模板目录因保留占位符，检查时加 `-AllowPlaceholders`。

## 3. 在 CI 中使用

```powershell
.\scripts\check-docs.ps1 -DocsPath ".\docs"
if ($LASTEXITCODE -ne 0) { exit 1 }
```
