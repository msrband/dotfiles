#!/bin/bash
set -euo pipefail

# fetch-linear-context.sh
# Creates LINEAR_CONTEXT.md from Linear issue based on branch name

# Extract issue ID from branch name (assumes format: ABC-123-description)
BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "")
ISSUE_ID=$(echo "$BRANCH_NAME" | grep -oE '^[A-Z]+-[0-9]+' || echo "")

if [ -z "$ISSUE_ID" ]; then
  exit 0
fi

# Get Linear API token from file (set by bootstrap.sh)
if [ ! -f "$HOME/.secrets/linear_api_token" ]; then
  exit 0
fi
LINEAR_API_TOKEN=$(cat "$HOME/.secrets/linear_api_token")

# Fetch issue details using linearis (via mise)
TMPFILE=$(mktemp)
trap "rm -f $TMPFILE" EXIT

if ! mise exec -- linearis --api-token "$LINEAR_API_TOKEN" issues read "$ISSUE_ID" > "$TMPFILE" 2>/dev/null; then
  exit 0
fi

if [ ! -s "$TMPFILE" ]; then
  exit 0
fi

# Parse JSON and create markdown file
TITLE=$(jq -r '.title // "Untitled"' "$TMPFILE")
DESCRIPTION=$(jq -r '.description // "No description"' "$TMPFILE")
STATUS=$(jq -r '.state.name // "Unknown"' "$TMPFILE")
IDENTIFIER=$(jq -r '.identifier // ""' "$TMPFILE")

cat > LINEAR_CONTEXT.md << EOF
# Linear Issue Context

**Issue**: $IDENTIFIER
**Title**: $TITLE
**Status**: $STATUS

## Description

$DESCRIPTION
EOF
