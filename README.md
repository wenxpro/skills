# Skills

个人 Zed agent skills 仓库。每个 skill 是独立的目录，含 `SKILL.md`（入口）及可选的引用文件（规范、模板等）。

## Skill 索引

- **docs-audit** — 文档集审核：交叉引用、翻译腔、版本锚点、图表覆盖、重复与数字核对
- **git-commit** — Git 提交：分析变更、按 Conventional Commits 生成 message、执行提交
- **topic-research** — 课题调研：生态全景、多入口交叉验证、证据分级，支撑外部结论写进文档
- **code-digest** — 代码库梳理：演进时间线 + 技术细节，防遗漏防过时、编号决策核对
- **roadmap-planning** — 演进规划：把设计结论按依赖链归入 MVP/V1/V2，定优先级与落点
- **implementation-track** — 实现跟踪：验收项状态（◻/🔄/✅/❌）与偏差记录回写

## 安装

把 skill 目录复制到对应位置，Zed 会在下次对话自动发现（全局目录已存在时无需重启）：

**全局（所有项目可用）**

```sh
cp -r docs-audit ~/.agents/skills/
```

**项目级（随仓库共享给协作者）**

```sh
cp -r docs-audit <project>/.agents/skills/
```

更新：重新执行上面的复制命令覆盖即可；卸载：删除对应目录。

装完在新会话中按 skill 的触发场景试探一句，确认能被自动加载。

## 新增/维护 skill

- 每个 skill 一个目录，目录名即 skill 名（小写字母数字、单连字符分隔）
- 目录内必须有 `SKILL.md`，以 YAML frontmatter 开头，`name` 必须与目录名一致，`description` 写清触发场景（何时用、何时不用）
- 若设置 `disable-model-invocation: true`，agent 不会自动加载该 skill，只能通过 `/` 命令菜单手动调用
- 个人/团队偏好（风格、术语、环境约定）放引用文件，`SKILL.md` 中只保留通用流程：这样其他团队/项目只需整体替换 `standards.md`，通用流程无需改动
- 引用文件用相对路径，如 `standards.md`、`templates/foo.md`
