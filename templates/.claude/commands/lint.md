Run RuboCop on changed files or the whole project, auto-correct fixable offenses, then fix any remaining offenses by editing the code directly.

## Steps

1. Get the list of changed Ruby files:
   ```bash
   git diff --name-only HEAD | grep '\.rb$'
   ```
   If there are changed files, run RuboCop on those files. If there are no changed files (e.g. clean working tree), run RuboCop on the whole project.

2. Run RuboCop:
   - On changed files: `bundle exec rubocop <file1> <file2> ...`
   - On whole project: `bundle exec rubocop`

3. If any offenses are found, attempt auto-correction:
   ```bash
   bundle exec rubocop -A <files or blank for all>
   ```

4. Re-run RuboCop to see what remains after auto-correction.

5. For each remaining offense that RuboCop could not auto-correct:
   - Read the offending file
   - Understand the root cause of the offense (don't just silence the cop)
   - Edit the code to fix it properly
   - Repeat for all remaining offenses

6. Re-run RuboCop to confirm all offenses are resolved and no new ones were introduced.
