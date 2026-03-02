Generate unit specs for the given source files.

## Steps

1. Read each source file specified in `$ARGUMENTS` to understand its public API, dependencies, and DB interactions.

2. Look at existing specs in the project to learn conventions (describe/context/it structure, factory patterns, test-prof usage).

3. Write spec files following these rules:
   - **Unit tests** — test each method/behavior in isolation; mock external dependencies
   - Use `let_it_be` / `let_it_be_refined` instead of `let` / `let!` for DB-backed test data
   - Use `AnyFixture` for shared reference data (roles, statuses, config records) that doesn't change across examples
   - Spec file placement mirrors source: `app/models/user.rb` → `spec/models/user_spec.rb`

4. Run each new spec with `FPROF=1` to check DB record creation:
   ```bash
   FPROF=1 bundle exec rspec <spec_file>
   ```

5. Review the FPROF output. If unnecessary DB records are created per-example, refactor test data to use `let_it_be` or `AnyFixture`.

6. Fix any failures and re-run until all specs are green.
