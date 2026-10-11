New Mac Runbook (for a coding agent)
===================================

The human-facing notes, with the background and links behind these choices, are
in [NEW_MAC.md](./NEW_MAC.md). This file is the executable version of them.

Written for a coding agent (Claude Code) to execute on a fresh Mac, with a human
nearby for the steps marked **[HUMAN]**. Goal: the same working environment as
the previous machine, rebuilt cleanly rather than cloned from a disk image.

What "the same" means:

- two project roots, `~/github` (personal/open source) and `~/byted` (work), each
  committing with its own identity and talking to its own git host
- shell, git, vim, Karabiner configuration from this repo
- agent tooling: Claude Code and Codex with the same settings, skills, plugins,
  MCP servers and memories
- no project clones (a list of what was cloned is provided, clone on demand)

Rules for the agent
-------------------

1. Run the phases in order. Every phase ends with **Verify**; do not start the
   next phase until it passes. If a check fails, fix the cause; do not write it
   off as unrelated.
2. **[HUMAN]** means stop and ask. Never type a password, token or passphrase,
   never copy a private key, never change macOS security settings yourself.
3. This repository is **public**. Nothing company-internal (hostnames, emails,
   internal package names, memories) may be committed to it. That material
   comes from the private bundle and lives in `~/.dotfiles-private/` and in
   untracked files under `$HOME`.
4. `~/.zshrc`, `~/.gitconfig` and friends are symlinks into this repo, and
   installers love to append to them. After every phase run
   `git -C ~/github/dotfiles status --short` and deal with what changed:
   keep it (using `$HOME`, never `/Users/<name>`), drop duplicates, or move
   machine-specific git settings to `~/.gitconfig.local`. Do not commit or push
   without asking.
5. The old machine's user was `bytedance`. Do not assume the new one is.
6. Do not clone project repos unless asked.

Phase 0: bootstrap **[HUMAN]**
------------------------------

Done by hand, because no agent exists yet.

```sh
xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
brew install --cask claude-code
mkdir -p ~/github ~/byted
git clone https://github.com/Huxpro/dotfiles.git ~/github/dotfiles
```

Then:

- copy `dotfiles-private-<date>.tgz` from the old machine (AirDrop) to `~/Downloads`
- `cd ~/github/dotfiles && claude`, log in, and say:
  *"Read NEW_MAC_AGENT.md and execute it starting at phase 1."*

**Verify**: `brew --version`, `git --version`, `ls ~/Downloads/dotfiles-private-*.tgz`.

Phase 1: packages and shell framework
-------------------------------------

```sh
brew bundle --file ~/github/dotfiles/Brewfile

# oh-my-zsh, without letting it replace ~/.zshrc or switch shells mid-script
RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions

# fzf key bindings (creates ~/.fzf.zsh, which .zshrc sources)
"$(brew --prefix)/opt/fzf/install" --key-bindings --completion --no-update-rc

# vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

The Brewfile is a dump of the old machine. A formula that no longer exists is
not a blocker: report it and continue.

**Verify**: `brew bundle check --file ~/github/dotfiles/Brewfile`;
`ls ~/.oh-my-zsh/custom/plugins` shows both plugins.

Phase 2: dotfiles, private bundle, identities
---------------------------------------------

```sh
~/github/dotfiles/install.sh --plan    # preview, changes nothing
~/github/dotfiles/install.sh
~/github/dotfiles/utils/unpack-private.sh ~/Downloads/dotfiles-private-*.tgz
direnv allow ~/byted                   # if the bundle placed ~/byted/.envrc
vim +PlugInstall +qall
```

`install.sh` is idempotent and moves anything it replaces to
`<path>.pre-dotfiles.<timestamp>`. `unpack-private.sh` never overwrites.

Now read `~/.dotfiles-private/NOTES.md`: it holds the work-side half of this
runbook (hosts, internal tools, internal skills).

### How the two identities work

| Root | Host | Transport | Commit email comes from |
| --- | --- | --- | --- |
| `~/github/` | github.com | HTTPS via `gh auth git-credential` (`git@github.com:` is rewritten to HTTPS) | `[user]` in `git/.gitconfig` |
| `~/byted/` | work git hosts | SSH | `~/.gitconfig-bytedance`, pulled in by `includeIf "gitdir:~/byted/"` |

The npm registry is also per root: `~/byted/.envrc` (direnv) and a `.npmrc` in
each root, restored from the private bundle with their tokens stripped. The
global `~/.npmrc` stays on the public registry.

`~/.gitconfig` (this repo) includes `~/.gitconfig.local` (private bundle:
`user.name`, work URL rewrites, anything machine-specific) near the top, sets the
personal email after it, and applies the `includeIf` last. Order matters; do not
reshuffle. Tools that run `git config --global` write into the tracked file;
move such entries to `~/.gitconfig.local`.

### Credentials **[HUMAN]**

None were transferred. Create fresh ones:

- GitHub: `gh auth login -h github.com -p https -w`, then
  `gh extension install github/gh-stack`
- SSH: `ssh-keygen -t ed25519`; the human registers the public key with the
  work git hosts (see private notes)
- npm: `npm login` for publishing if needed (`~/.npmrc` is never synced); the
  human re-adds the registry tokens that were stripped from `~/byted/.envrc`
  and `~/byted/.npmrc`

**Verify**: `~/github/dotfiles/utils/verify.sh`. The `shell`, `git identities`
and `npm registry per root` sections must pass; `tools` and `agents` will still
have failures until phases 3 and 4.

Phase 3: language runtimes
--------------------------

```sh
# nvm: use the install command from https://github.com/nvm-sh/nvm#installing-and-updating
nvm install 22 && nvm alias default 22
nvm install 24

curl -fsSL https://get.pnpm.io/install.sh | sh -      # ~/Library/pnpm
curl -fsSL https://bun.sh/install | bash              # ~/.bun
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
curl -LsSf https://astral.sh/uv/install.sh | sh       # ~/.local/bin

npm install -g @openai/codex @larksuite/cli agent-browser agent-device
```

`.zshrc` already has the nvm (lazy-loaded), pnpm, bun and cargo blocks, so undo
whatever the installers append (rule 4). Two things to know about Node:

- the lazy loader puts the newest install matching `nvm alias default` on
  `PATH` without loading nvm
- `npm install -g` under nvm is per Node version, so install the globals after
  the last `nvm install`, and again whenever a newer Node is added

Xcode **[HUMAN]**: install from the App Store, open it once, accept the license,
install an iOS simulator runtime. Android: `android-commandlinetools` and
`temurin` come from the Brewfile; install SDK packages on demand.

**Verify**: `node -v && pnpm -v && bun -v && rustc -V && uv --version && codex --version`
in a new shell; `xcode-select -p` points into `Xcode.app`.

Phase 4: agents
---------------

`install.sh` has already linked `~/.claude/CLAUDE.md`, merged
`claude/settings.base.json` into `~/.claude/settings.json`, and seeded
`~/.codex/config.toml`.

```sh
# Claude Code: user-scope MCP server (no plugins are part of the baseline)
claude mcp add --scope user lynx-docs -- npx -y @lynx-js/docs-mcp-server@latest

# Global skills from public sources (~/.agents/skills, symlinked into ~/.claude/skills)
~/github/dotfiles/agents/skills.sh install

# Codex and Lark CLI logins [HUMAN]
codex login
lark-cli auth login
```

The skill set is deliberately small (about 20 public skills plus a handful of
internal ones). It was pruned from ~100 after checking real usage: every
installed skill costs context in every session, and past a budget their
descriptions get dropped. Add a skill when a task needs it, not in advance.

Internal skills and internal agent tooling: follow `~/.dotfiles-private/NOTES.md`
once work SSH access is up.

Things to know:

- **Memories** were restored to `~/.claude/projects/<key>/memory`, where `<key>`
  is the project's absolute path. They attach only if a repo is cloned to the
  same place relative to `$HOME` as before (`~/github/<name>`, `~/byted/<name>`).
- **Permissions are wide open on purpose**: the `cc`/`yolo`/`cx` aliases skip
  permission prompts, `settings.base.json` sets
  `skipDangerousModePermissionPrompt`, and Codex runs with
  `sandbox_mode = "danger-full-access"`. This mirrors the old machine; it is a
  choice, not an accident.
- **Hooks and status line** in `~/.claude/settings.json` on the old machine were
  injected by a desktop app, which re-injects them when installed. They are not
  part of `settings.base.json`.
- The tmux helpers (`ccx`/`cca`/`cxx`...) use `tmux -CC`, which needs iTerm2.

**Verify**: `~/github/dotfiles/utils/verify.sh` passes completely.

Phase 5: macOS and apps **[HUMAN]**, agent assists
--------------------------------------------------

System Settings:

- Keyboard: map Caps Lock to Control
- Trackpad: three finger drag, tap to click, App Exposé
- Appearance: Auto
- Default browser: Google Chrome

The agent may run:

```sh
defaults write -g ApplePressAndHoldEnabled -bool false   # key repeat instead of accent menu
```

Apps (the commented casks at the bottom of the Brewfile cover most of these):

- iTerm2. General > Theme "Minimal"; Panes: no per-pane title bar; no dimming of
  inactive panes; Profile: silence bell, "Reuse previous session's directory";
  Colors: import `theme/One Light.itermcolors` and `theme/One Dark.itermcolors`
  as profiles named `Default` and `Dark` (`.zshrc` switches between them).
- Font: [Iosevka](https://github.com/be5invis/Iosevka) (SS05)
- Karabiner-Elements: config already seeded to `~/.config/karabiner/`; needs
  Input Monitoring permission
- Rectangle (2.x, installed by the Brewfile). `Ctrl+Option` is shared with the
  Karabiner app launcher: arrows and digits place windows, every letter is free
  for apps. A digit means "split the screen into that many parts" and repeating
  it cycles through them. `1` (center, full screen, restore) and `2` (left/right
  halves) are Karabiner rules that drive Rectangle; `3`, `4` and `6` are
  Rectangle's own. The agent may apply these with Rectangle quit, then
  start it:

  ```sh
  D=com.knollsoft.Rectangle
  defaults write $D alternateDefaultShortcuts -bool true   # the Ctrl+Option set
  defaults write $D subsequentExecutionMode -int 5         # repeat: corners cycle position, sides cycle size
  defaults write $D halvesPreserveOtherAxisSize -bool true # on a tiled window an arrow resizes its own axis only (quarter <-> sixth)
  defaults write $D firstThird -dict-add keyCode -float 20 modifierFlags -float 786432   # Ctrl+Option+3: thirds
  defaults write $D topLeft -dict-add keyCode -float 21 modifierFlags -float 786432      # Ctrl+Option+4: corners
  defaults write $D topLeftSixth -dict-add keyCode -float 22 modifierFlags -float 786432 # Ctrl+Option+6: sixths
  # letter shortcuts Rectangle ships with; an empty value clears one
  for k in topRight bottomLeft bottomRight centerThird lastThird firstTwoThirds lastTwoThirds center toggleTodo reflowTodo; do
    defaults write $D $k -dict
  done
  ```
- Raycast, Ghostty, VS Code (Settings Sync restores extensions), Cursor,
  Claude desktop, ChatGPT/Codex desktop, cmux, Obsidian, Notion, Chrome,
  Google Drive, IINA, PDF Expert, Sogou Pinyin
- Company apps: see private notes

Optional, human only: `sudo spctl --master-disable` to allow apps from anywhere.

Phase 6: final check and report
-------------------------------

```sh
~/github/dotfiles/install.sh --plan   # prints only "plan only, nothing changed."
~/github/dotfiles/utils/verify.sh
```

Report to the human: what passed, what was skipped and why, every **[HUMAN]**
item still open, and any diff left in this repo. Offer the repo list in
`~/.dotfiles-private/REPOS.md` for cloning.

Keeping machines in sync
------------------------

| What | How it syncs |
| --- | --- |
| shell, git, vim, `claude/CLAUDE.md` | symlinks; edit in place, commit here |
| Claude settings | edit `claude/settings.base.json`, re-run `install.sh` |
| Karabiner, Codex config | copy the live file back into this repo when it is worth keeping |
| global skills | `agents/skills.sh dump` after adding or removing skills |
| Homebrew | `brew bundle dump --force --file Brewfile`, then strip internal taps and `npm`/`vscode` lines |
| private bundle | `utils/pack-private.sh` on the source machine, `utils/unpack-private.sh` on the target |

Appendix: toolchains installed on demand
----------------------------------------

Not part of the baseline; install when a project needs them.

- Python: `pyenv` (`.zprofile` already has the PATH entries)
- JVM: `openjdk@11`/`@17` (Brewfile), Gradle, Scala (`brew install scala sbt`)
- Native: LLVM (`brew install llvm`), CMake (Brewfile), Emscripten (`emsdk`)
- Neovim (`install.sh` links `nvim/` when `~/.config/nvim` exists), Spacemacs
- JetBrains Toolbox with IdeaVim (`~/.ideavimrc` is linked), Android Studio
- OCaml (opam), Haskell (ghcup), Racket, SML/NJ, Coq, Agda
- Docker, Dash, Monodraw, `im-select` (`brew tap daipeihust/tap && brew install im-select`)
