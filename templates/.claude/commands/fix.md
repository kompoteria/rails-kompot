Diagnose and fix a failing test, RuboCop offense, or error. Pass a description of the problem as the argument.

Usage: `/fix <description of the problem>`

Examples:
- `/fix bundle exec rspec spec/models/user_spec.rb:42 is failing`
- `/fix rubocop offense: Metrics/MethodLength in app/services/user_service.rb`
- `/fix NoMethodError: undefined method 'foo' for nil:NilClass in app/controllers/users_controller.rb`

## Steps

1. Read the relevant file(s) identified in the problem description.

2. Diagnose the root cause — do not guess; trace the actual error or failing assertion.

3. Apply the minimal fix needed to resolve the issue.

4. Verify the fix by re-running the relevant command:
   - **Failing test**: `bundle exec rspec <path/to/spec_file>` (use the specific file and line if available)
   - **RuboCop offense**: `bundle exec rubocop <path/to/file>`
   - **Runtime error**: re-run the command or request that raised the error

5. If the fix passes verification, report what was changed and why. If it still fails, diagnose further before trying another approach.
