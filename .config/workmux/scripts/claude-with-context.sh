#!/bin/bash
# claude-with-context.sh
# LINEAR_CONTEXT.md가 있으면 시스템 프롬프트로 추가하여 claude 실행

if [ -f "LINEAR_CONTEXT.md" ]; then
  exec claude --append-system-prompt "$(cat LINEAR_CONTEXT.md)" "$@"
else
  exec claude "$@"
fi
