#!/usr/bin/env bash
# 安装 skills 仓库本地 Git hooks。
# 使用：bash scripts/install-git-hooks.sh
set -euo pipefail

repo_root=$(git rev-parse --show-toplevel)
cd "$repo_root"

git config core.hooksPath scripts/hooks
chmod +x scripts/hooks/pre-push scripts/check-skills.sh

echo "installed: core.hooksPath=scripts/hooks"
echo "pre-push will run scripts/check-skills.sh"
