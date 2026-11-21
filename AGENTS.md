# Agent instructions

Read [README.md](README.md) and apply the relevant [house-style standards](https://github.com/pacharanero/house-style/blob/main/AGENTS.md) and the host Discourse repository's plugin conventions.

Keep this plugin to an opt-in list of HTML routes and preserve the host's routing precedence and login requirements. Do not add theme assets, page content or data access.

Run the request specs in a Discourse test environment and `git diff --check` before committing. Commit validated changes locally; wait for approval before publishing or deploying. Hosted CI is not yet configured; the host-backed request specs are the current check.
