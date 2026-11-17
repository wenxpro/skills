#!/usr/bin/env bash
# 生成 README 的「Skill 索引」节：定位文本取自各 SKILL.md description 的首句，
# 分类映射在本脚本内维护。--check 模式只校验同步，不写文件。
set -uo pipefail

cd "$(dirname "$0")/.."

BEGIN_MARK='<!-- BEGIN GENERATED: skill-index -->'
END_MARK='<!-- END GENERATED: skill-index -->'
README=README.md

# 分类映射：每行「分类名 skill1 skill2 ...」。新增 skill 必须登记到这里。
mapping() {
  cat <<'EOF'
阶段 design-stage delivery-stage feedback-stage
基础与方法 docs-core game-docs narrative-docs software-docs backend-design ui-baseline experience-architecture responsibility-design validation-design game-combat-model game-systems-balance level-encounter-design game-ai-design
游戏实现 godot-game-runtime game-animation-rig game-feel game-audio game-stealth game-choice-consequence game-roguelite
输入与决策 topic-research code-digest docs-audit implementation-track review roadmap-planning
交付与集成 execution-loop code-review git-commit worktree-workflow llm-integration cross-project-integration
会话与维护 session-handoff skill-audit
EOF
}

fail() { echo "FAIL: $*" >&2; exit 1; }

# 完整性：每个 skill 目录恰好登记一次，登记项必须存在
listed=$(mapping | awk '{for(i=2;i<=NF;i++) print $i}' | sort)
actual=$(for d in */; do d=${d%/}; [ "$d" = scripts ] && continue; echo "$d"; done | sort)
dup=$(echo "$listed" | uniq -d)
[ -z "$dup" ] || fail "映射重复登记: $dup"
missing=$(comm -13 <(echo "$listed") <(echo "$actual"))
[ -z "$missing" ] || fail "skill 未登记到分类映射: $missing"
ghost=$(comm -23 <(echo "$listed") <(echo "$actual"))
[ -z "$ghost" ] || fail "映射登记了不存在的 skill: $ghost"

# 生成索引节
section=$(mktemp)
expected=
trap 'rm -f "$section" ${expected:+"$expected"}' EXIT
while read -r cat skills; do
  printf '### %s\n\n| Skill | 定位 |\n|---|---|\n' "$cat"
  for d in $skills; do
    desc=$(sed -n 's/^description: //p' "$d/SKILL.md" | head -1)
    [ -n "$desc" ] || fail "$d: missing description"
    summary=${desc%%。*}
    summary=${summary//|/\\|}
    printf '| `%s` | %s |\n' "$d" "$summary"
  done
  printf '\n'
done < <(mapping) > "$section"

grep -qF "$BEGIN_MARK" "$README" || fail "README 缺少生成标记: $BEGIN_MARK"
grep -qF "$END_MARK" "$README" || fail "README 缺少生成标记: $END_MARK"

# 拼接期望的完整 README
expected=$(mktemp)
awk -v b="$BEGIN_MARK" -v e="$END_MARK" -v f="$section" '
  $0 == b { print; while ((getline line < f) > 0) print line; close(f); skip = 1; next }
  $0 == e { skip = 0 }
  !skip { print }
' "$README" > "$expected"

if [ "${1:-}" = --check ]; then
  if ! diff -q "$README" "$expected" >/dev/null; then
    fail "README 索引与 frontmatter 不同步，运行 bash scripts/gen-readme-index.sh 重新生成"
  fi
  echo "readme index in sync"
else
  mv "$expected" "$README"
  trap 'rm -f "$section"' EXIT
  echo "readme index regenerated"
fi