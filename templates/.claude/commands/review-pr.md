Review the current branch against main and provide actionable feedback.

## Steps

1. Get the diff of the current branch against main:

   ```bash
   git diff main...HEAD
   ```

2. Also get the list of changed files:

   ```bash
   git diff --name-only main...HEAD
   ```

3. Review the changes for:
   - **Code quality** — clarity, duplication, naming, Rails conventions
   - **N+1 queries** — look for loops with ActiveRecord calls that lack `.includes`/`.preload`/`.eager_load`; Bullet will surface these at runtime but flag obvious ones in review
   - **Missing specs** — for each new model, controller, service, or public method, check that a corresponding spec exists or is added in this PR
   - **RuboCop compliance** — flag style issues not caught by auto-correct (complex logic, missing frozen_string_literal, etc.)
   - **Documentation type consistency** — For each changed file under `app/`, check whether a corresponding `docs/` file exists (mirror path: replace `app/` prefix with `docs/` and `.rb` with `.md`). If it does, read the documented input/output types for each method. Then inspect callers of those methods in the diff and verify that arguments passed are consistent with the documented types. Flag type mismatches as **blockers**.

4. End with a summary: overall assessment, blockers vs. suggestions, and any positive highlights.

5. Fix every **blocker** identified in the summary:
   - Edit the relevant source files directly to resolve each blocking issue.
   - After applying fixes, re-run the test suite and RuboCop to verify no regressions were introduced:

     ```bash
     bundle exec rspec
     bundle exec rubocop
     ```

   - If new failures appear, fix them before finishing.
