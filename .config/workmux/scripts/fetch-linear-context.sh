#!/bin/bash
set -euo pipefail

# fetch-linear-context.sh
# Creates LINEAR_CONTEXT.md from Linear issue based on branch name
# Uses Linear GraphQL API directly (no linearis dependency)

# Extract issue ID from branch name (assumes format: ABC-123-description)
BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "")
ISSUE_ID=$(echo "$BRANCH_NAME" | grep -oE '^[A-Z]+-[0-9]+' || echo "")

if [ -z "$ISSUE_ID" ]; then
  exit 0
fi

# Get Linear API token from file
if [ ! -f "$HOME/.secrets/linear_api_token" ]; then
  exit 0
fi
LINEAR_API_TOKEN=$(cat "$HOME/.secrets/linear_api_token")

# Fetch issue via Linear GraphQL API
# Using heredoc to avoid bash escaping issues with '!'
TMPFILE=$(mktemp)
trap "rm -f $TMPFILE" EXIT

read -r -d '' QUERY << 'GRAPHQL' || true
query($id: String!) {
  issue(id: $id) {
    identifier
    title
    description
    state { name }
    comments(first: 50) {
      nodes {
        body
        createdAt
        user { name }
      }
    }
  }
}
GRAPHQL

if ! curl -s -X POST https://api.linear.app/graphql \
  -H "Authorization: $LINEAR_API_TOKEN" \
  -H "Content-Type: application/json" \
  -d "$(jq -n --arg query "$QUERY" --arg id "$ISSUE_ID" '{query: $query, variables: {id: $id}}')" \
  > "$TMPFILE" 2>/dev/null; then
  exit 0
fi

# Check if we got valid data
if ! jq -e '.data.issue' "$TMPFILE" > /dev/null 2>&1; then
  exit 0
fi

# Parse JSON
IDENTIFIER=$(jq -r '.data.issue.identifier // ""' "$TMPFILE")
TITLE=$(jq -r '.data.issue.title // "Untitled"' "$TMPFILE")
DESCRIPTION=$(jq -r '.data.issue.description // "No description"' "$TMPFILE")
STATUS=$(jq -r '.data.issue.state.name // "Unknown"' "$TMPFILE")

# Format comments (handle null users gracefully)
COMMENTS=$(jq -r '.data.issue.comments.nodes | reverse | map(
  "- **" + (if .user then .user.name else "Unknown" end) + "**: " + (.body | split("\n")[0])
) | join("\n")' "$TMPFILE")

# Create markdown file
cat > LINEAR_CONTEXT.md << EOF
# Linear Issue Context

**Issue**: $IDENTIFIER
**Title**: $TITLE
**Status**: $STATUS

## Description

$DESCRIPTION

## Comments

$COMMENTS
EOF
