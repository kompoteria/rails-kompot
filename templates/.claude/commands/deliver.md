Run all quality gates in sequence, fixing issues as you go, until everything is green.

## Steps

1. **Tests + FPROF** — Run `FPROF=1 bundle exec rspec`. If any specs fail, use `/fix` to diagnose and resolve each failure. Review FPROF output — if any example group creates excessive DB records, refactor to use `let_it_be` / `before_all`. Re-run until green.

2. **Code coverage** — Run `bundle exec rspec` to generate a fresh SimpleCov report, then run the `/code-coverage` skill to identify under-covered files and write missing specs. Re-run until all files meet the 80% threshold.

3. **Lint** — Run the `/lint` skill to auto-correct and fix all RuboCop offenses.

4. **Code review** — Run the `/review-pr` skill to diff against main, review for quality issues, and fix all blockers.

5. **Documentation** — Identify changed `.rb` files under `app/` with:

   ```bash
   git diff --name-only main | grep '^app/.*\.rb$'
   ```

   Run the `/docs` skill on those files to create or update their documentation in `docs/`.

6. **Final verification** — Re-run `FPROF=1 bundle exec rspec` and `bundle exec rubocop`. If anything fails, return to the relevant step. Repeat until both are clean.

7. **Commit** — If there are uncommitted changes, run the `/commit` skill.
