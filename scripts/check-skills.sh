#!/usr/bin/env bash
# CI 检查：skill 结构、frontmatter、本机路径、相对链接、废弃术语。
set -uo pipefail

cd "$(dirname "$0")/.."
fail=0
err() { echo "FAIL: $*"; fail=1; }

# 1. 每个 skill 目录：SKILL.md 存在、name 匹配目录、description 存在且不超 1024 字符
for d in */; do
  d=${d%/}
  case "$d" in
    .github|.git|scripts) continue ;;
  esac
  [ -f "$d/SKILL.md" ] || { err "$d: missing SKILL.md"; continue; }
  name=$(sed -n 's/^name: //p' "$d/SKILL.md" | head -1)
  [ "$name" = "$d" ] || err "$d: name '$name' does not match directory"
  desc=$(sed -n 's/^description: //p' "$d/SKILL.md" | head -1)
  [ -n "$desc" ] || err "$d: missing description"
  len=${#desc}
  [ "$len" -le 1024 ] || err "$d: description too long ($len > 1024)"
done

# 2. SKILL.md 不得出现本机绝对路径（示例行除外）；standards 属偏好层，允许项目配置路径
while IFS= read -r line; do
  [ -n "$line" ] && err "absolute path: $line"
done < <(grep -rn -E '~/|/Volumes/|/Users/' --include='SKILL.md' . 2>/dev/null | grep -v -E '示例|example|扫描种子|模式')

# 3. 相对 markdown 链接可解析（仅 SKILL.md 与 README）
check_links() {
  local file=$1 dir target
  dir=$(dirname "$file")
  while IFS= read -r target; do
    [ -z "$target" ] && continue
    case "$target" in
      http*|mailto:*|\#*) continue ;;
    esac
    target=${target%%#*}
    [ -z "$target" ] && continue
    [ -e "$dir/$target" ] || err "$file: broken link -> $target"
  done < <(grep -oE '\]\([^)#]+\)' "$file" | sed -E 's/^\]\(//; s/\)$//')
}

for f in README.md */SKILL.md */standards.md; do
  [ -f "$f" ] && check_links "$f"
done

# 4. 废弃术语扫描（词表见 skill-audit/references/terminology.md）
# 允许术语表自身、明确标注的迁移说明/历史原文；其他命中一律失败。
while IFS= read -r line; do
  [ -n "$line" ] && err "deprecated term: $line"
done < <(
  grep -rn -E '契约|门禁|阻断' --include='*.md' --exclude-dir=.git . 2>/dev/null \
    | grep -v 'skill-audit/references/terminology.md' \
    | grep -v -E '旧词|原词|迁移|替代|不要写|反例'
)

if [ "$fail" -ne 0 ]; then
  echo "skills check failed"
  exit 1
fi
echo "skills check passed"
