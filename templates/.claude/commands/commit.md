Analyze the staged and unstaged changes and create a commit with a minimal, accurate message.

## Steps

1. Inspect what has changed:

   ```bash
   git status
   git diff
   git diff --cached
   ```

2. Analyze the changes and derive the commit message:
   - Identify the single most important thing the changes accomplish.
   - Use the conventional format: `<type>: <short description>` (e.g. `feat:`, `fix:`, `refactor:`, `test:`, `chore:`).
   - Keep the subject line under 72 characters.
   - Use the imperative mood ("add", "fix", "remove" — not "added", "fixes").
   - Do not pad with filler words or repeat the diff verbatim.
   - If the changes span genuinely unrelated concerns, split into multiple commits.

3. Stage all relevant changes and commit:

   ```bash
   git add -p   # or git add <specific files>
   git commit -m "<type>: <short description>"
   ```

   Do not include `--no-verify` or any flag that bypasses hooks.
   Do not include co-authors in a commit.
