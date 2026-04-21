#!/bin/bash
# MCP Tool Discovery Activation Hook
# Reminds Claude when MCP tools are appropriate vs basic tools

# Build the system message
read -r -d '' MESSAGE <<'PROMPT'
GUIDANCE: MCP TOOL DISCOVERY

You have access to a tool-executor MCP that wraps 7 specialized MCP servers with 96 tools.
Basic tools (Read, Grep, Glob, Bash) are your DEFAULT. Use MCP only when basic tools cannot do the job.

## Decision rule: basic tools first

| Task | Default | Use MCP instead when... |
|------|---------|------------------------|
| Read a file | `Read` | never |
| Search for string | `Grep` | need semantic/symbol search → Serena |
| Find files | `Glob` | never |
| Run commands | `Bash` | never |
| Analyze visible code | your reasoning | cross-repo security audit → Gemini |
| Library docs | `WebFetch` | official structured docs → Context7 |
| Web research | `WebSearch` | need synthesis of many sources → Gemini |
| Summarize content | your reasoning | never |

## When MCP genuinely helps (use search_tools → get_tool_schema → execute_code):
- "Find where symbol X is defined/used across the codebase" → Serena semantic search
- "Rename this function everywhere" → Serena rename_symbol
- "What's the full API for library Y?" → Context7 query-docs
- "Research external topic, WebSearch gave sparse results" → Gemini deep-research
- "Brainstorm with a second AI perspective" → Gemini brainstorm
- "Generate an image" → Gemini image generation
- "Help me reason through a complex multi-step problem" → Sequential-thinking
- "Build a UI component" → shadcn
- "Scrape data from a website" → Apify

## MCP workflow (when you do use it):
1. search_tools("describe what you need") — find the tool
2. get_tool_schema("tool_name") — get exact parameters
3. execute_code(...) — run it

Proceed with your task.
PROMPT

# Output JSON with systemMessage for Claude to see
# Escape the message for JSON (newlines, quotes)
ESCAPED=$(echo "$MESSAGE" | python3 -c 'import json,sys; print(json.dumps(sys.stdin.read()))')

cat <<EOF
{
  "continue": true,
  "hookSpecificOutput": {
    "hookEventName": "UserPromptSubmit",
    "additionalContext": $ESCAPED
  }
}
EOF
