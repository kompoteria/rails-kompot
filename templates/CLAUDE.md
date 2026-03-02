# Project

This is a Rails API-only application generated with [rails-kompot](https://github.com/kompoteria/rails-kompot).

## Stack

- **Rails** — API-only mode (`config.api_only = true`)
- **PostgreSQL** — primary database
- **Minimal** — only essential gems included (`--minimal` flag)
- **RSpec** — test framework (rspec-rails), with SimpleCov for coverage and test-prof for profiling
- **RuboCop** — linting and style enforcement (rubocop-rails, rubocop-rspec)
- **Bullet** — N+1 query detection (enabled in development)

## Key conventions

- Routes live in `config/routes.rb`; prefer namespaced API versioning (e.g. `namespace :api { namespace :v1 { ... } }`)
- Controllers inherit from `ActionController::API`
- Use `render json:` for responses; avoid views and assets
- Keep business logic out of controllers — use plain Ruby objects or service objects in `app/`
- Database credentials are in `config/database.yml`; use environment variables for secrets

## Setup

```bash
bin/rails db:create db:migrate
bin/rails server
```

## Testing

```bash
# Run the full test suite
bundle exec rspec

# Run a specific file
bundle exec rspec spec/models/user_spec.rb

# Run a specific example
bundle exec rspec spec/models/user_spec.rb:42

# Run with coverage report (SimpleCov outputs to coverage/)
bundle exec rspec
```

## Linting

```bash
# Check for offenses
bundle exec rubocop

# Auto-correct fixable offenses
bundle exec rubocop -A

# Check a specific file
bundle exec rubocop app/models/user.rb
```

## Available Claude skills

This project includes custom Claude Code slash commands in `.claude/commands/`:

- `/lint` — Run RuboCop on changed files (or whole project) and auto-correct fixable offenses
- `/review-pr` — Diff current branch against main and review for code quality, N+1s, missing specs, and style
- `/fix` — Diagnose and fix a failing test, RuboCop offense, or error message
- `/code-coverage` — Run RSpec, analyze SimpleCov results, and suggest specs to add
- `/add-tests` — Generate unit specs for given source files using test-prof conventions
- `/commit` — Analyze staged and unstaged changes and create a commit with a minimal, accurate conventional message
- `/docs` — Generate or update markdown documentation in `docs/` for given `app/` source files, mirroring their path structure
- `/deliver` — Run all quality gates (tests+FPROF, coverage, RuboCop, code review) in a loop, fixing issues until everything is green, then commit

## Self-improvement

When a skill fails, produces incorrect output, or the user requests adjustments to Claude's behavior (e.g. "always do X", "stop doing Y", "add Z to reviews"), ask the user whether they'd like to update the relevant skill file in `.claude/commands/` or `CLAUDE.md` to capture the adjustment. This prevents repeating the same mistakes across sessions.
