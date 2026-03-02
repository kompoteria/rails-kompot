# rails-kompot

A CLI wrapper around `rails new` that bootstraps a production-ready API-only Rails application with testing, linting, and Claude Code skills pre-configured.

## Installation

```bash
gem install rails-kompot
```

## Usage

```bash
rails-kompot new my_app
```

This creates a new Rails app configured for:

- **PostgreSQL** — primary database
- **API-only mode** — no views, assets, or browser middleware
- **Minimal footprint** — only essential Rails components loaded

## What you get

### Gems

| Gem | Purpose |
|-----|---------|
| `rspec-rails` | Test framework |
| `factory_bot_rails` | Test factories |
| `rubocop` + `rubocop-rails` + `rubocop-rspec` | Linting and style enforcement |
| `test-prof` | Test profiling (FPROF, `let_it_be`, `before_all`) |
| `simplecov` | Code coverage reporting |
| `bullet` | N+1 query detection in development |

### Configuration

- **`.rubocop.yml`** — pre-configured with Rails and RSpec cops
- **SimpleCov** — configured in `spec/spec_helper.rb` with an 80% minimum coverage threshold
- **Bullet** — enabled in `config/environments/development.rb` with Rails logger output

### Claude skills

The generated app includes 8 custom Claude Code slash commands in `.claude/commands/`:

| Skill | Description |
|-------|-------------|
| `/lint` | Run RuboCop on changed files and auto-correct fixable offenses |
| `/review-pr` | Diff current branch against main; review for quality, N+1s, missing specs, and type consistency |
| `/fix` | Diagnose and fix a failing test, RuboCop offense, or error message |
| `/code-coverage` | Run RSpec, parse SimpleCov output, and suggest specs for under-covered files |
| `/add-tests` | Generate RSpec unit specs for given source files using test-prof conventions |
| `/commit` | Analyze changes and create a conventional commit message |
| `/docs` | Generate or update `docs/` markdown for given `app/` source files |
| `/deliver` | Run all quality gates in a loop until green, then commit |

### `/docs` skill

`/docs` mirrors your `app/` directory into `docs/` as structured markdown. For each source file you pass it:

1. Reads the class/module and infers method input/output types from signatures, defaults, guard clauses, return expressions, and `db/schema.rb`
2. Greps the codebase for callers to identify business flows
3. Creates or updates `docs/<path>.md` — preserving any manually-added notes while refreshing auto-generated sections

Example: `/docs app/models/user.rb app/services/payment_processor.rb`

### `/deliver` workflow

`/deliver` is a one-command quality gate loop:

1. **Tests + FPROF** — runs `FPROF=1 bundle exec rspec`; fixes failures; refactors excessive DB record creation to use `let_it_be`/`before_all`
2. **Coverage** — generates a fresh SimpleCov report and runs `/code-coverage` to add missing specs until the 80% threshold is met
3. **Lint** — runs `/lint` to auto-correct and fix all RuboCop offenses
4. **Code review** — runs `/review-pr` and fixes every blocker
5. **Docs** — runs `/docs` on all changed `app/` files to create or update their `docs/` markdown
6. **Final verification** — re-runs tests and RuboCop; returns to the relevant step if anything fails
7. **Commit** — runs `/commit` to create a conventional commit

You make code changes, then run `/deliver` — Claude handles the rest.

## Requirements

- Ruby >= 3.0
- Rails (railties) >= 7.0

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kompoteria/rails-kompot. Please open an issue before submitting a pull request for significant changes.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
