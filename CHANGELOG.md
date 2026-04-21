# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.2] - 2026-04-21

### Changed

- `UserPromptSubmit` hook (`search-tools-activation.sh`): renamed from MANDATORY to GUIDANCE; inverted priority to native-tools-first — Read/Grep/Glob/Bash are the default, MCP tools only when basic tools cannot do the job
- Removed Gemini from default quick-reference for code analysis and content summarisation (Claude handles these natively)
- `using-tool-executor` skill: updated tool-selection table — web research now defaults to `WebSearch`, Gemini deep-research only as fallback when WebSearch is insufficient
- `plugin.json`: updated author, homepage, and repository to fipnooone fork

## [1.0.1] - 2026-01-20

### Fixed

- Hook scripts now executable (session-start.sh, search-tools-activation.sh)
- UserPromptSubmit matcher changed from invalid `*` to valid `.*` regex
- Agent field renamed from `whenToUse` to `description` (spec compliance)
- Standardized plugin.json metadata format

## [1.0.0] - 2026-01-14

### Added

- Initial release
- 3-tool interface: search_tools, get_tool_schema, execute_code
- Semantic search over 102 tool definitions (Serena-powered with BM25 fallback)
- Sandboxed TypeScript execution with pre-connected MCP clients
- Workspace API for file operations
- 7 example MCP servers (96 tools)
- Context reduction from ~25% to 0.5% of context window
