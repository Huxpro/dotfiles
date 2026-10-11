# Agent notes for this repo

Personal dotfiles, symlinked into `$HOME` by `install.sh`. **This repo is public.**

- Setting up a machine: follow [NEW_MAC_AGENT.md](./NEW_MAC_AGENT.md). `NEW_MAC.md` and `NEW_SERVER.md` are the owner's personal notes; do not rewrite them.
- Never commit company-internal material (hostnames, emails, internal package
  or repo names, agent memories) or credentials. That lives in the private
  bundle (`utils/pack-private.sh`) and in untracked files such as
  `~/.gitconfig.local`, `~/.gitconfig-bytedance`, `~/.ssh/config`.
- Paths use `$HOME` or `~`, never `/Users/<name>`.
- `~/.zshrc`, `~/.gitconfig` etc. are symlinks to files here, so installers and
  `git config --global` modify this repo. Review `git status` before assuming a
  diff is intentional; machine-specific git settings belong in `~/.gitconfig.local`.
- Files an app rewrites on its own (Karabiner, `~/.claude/settings.json`,
  `~/.codex/config.toml`) are seeded or merged, not symlinked. See the header of
  `install.sh`.
- `install.sh` must stay idempotent and must not destroy existing files.

## Layout

| Path | Purpose |
| --- | --- |
| `zsh/`, `bash/`, `git/`, `vim/`, `nvim/`, `emacs/` | classic dotfiles (`~/.ideavimrc` links to `vim/.vimrc`) |
| `claude/` | Claude Code: user `CLAUDE.md`, `settings.base.json`; optional `commands/` and `skills/` are linked if present |
| `agents/` | global skill manifest (`skills.tsv`) and `skills.sh` to dump/install it |
| `codex/` | seed for `~/.codex/config.toml` |
| `Brewfile` | Homebrew packages |
| `karabiner/`, `theme/`, `alfred/` | app configuration |
| `utils/pack-private.sh`, `utils/unpack-private.sh` | out-of-band transfer of private config |
| `utils/verify.sh` | read-only health check of a set-up machine |
