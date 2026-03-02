Analyze existing SimpleCov coverage results and write missing specs to improve coverage.

## Steps

1. Read the existing coverage report at `coverage/index.html`. Do not run the test suite — assume the user has already run it and the report is current.

2. Parse the HTML report for:
   - **Overall coverage percentage**
   - **Files below 80% coverage** — list each file with its coverage percentage
   - **Uncovered lines** — for each low-coverage file, identify which methods or branches are not covered

3. For each low-coverage file, read the source file to understand what needs to be tested.

4. Write the missing specs:
   - Create or extend the appropriate spec file (e.g. `spec/models/user_spec.rb`)
   - Cover the uncovered methods, branches, and edge cases identified in step 2
   - Follow existing spec conventions in the project (describe/context/it blocks, factory usage, etc.)
   - **Unit tests** — test each method/behavior in isolation; mock external dependencies
   - Use `let_it_be` / `let_it_be_refined` instead of `let` / `let!` for DB-backed test data
   - Use `AnyFixture` for shared reference data (roles, statuses, config records) that doesn't change across examples

5. Run each new or modified spec with `FPROF=1` to check DB record creation:
   ```bash
   FPROF=1 bundle exec rspec <spec_file>
   ```
   Review the FPROF output — if unnecessary DB records are created per-example, refactor test data to use `let_it_be` or `AnyFixture`. Fix any failures before moving on to the next file.
