# Declarative version of the install lists in NEW_MAC.md.
#
#   brew bundle --file=~/dotfiles/Brewfile          # install / upgrade
#   brew bundle check --file=~/dotfiles/Brewfile    # what's missing
#
# Lines that are commented out are optional or machine specific.

tap "daipeihust/tap"   # im-select

# ---------------------------------------------------------------------------
# CLI - required by the configs in this repo
# ---------------------------------------------------------------------------
brew "git"
brew "git-lfs"         # [filter "lfs"] in git/.gitconfig
brew "gh"              # credential helper in git/.gitconfig
brew "coreutils"       # gnubin on PATH in zsh/.zprofile
brew "sqlite"          # keg-only, on PATH in zsh/.zprofile
brew "direnv"          # hooked in zsh/.zshrc
brew "fzf"             # zsh + vim (<C-p>)
brew "ripgrep"         # vim :Rg (<leader>f)
brew "vim"             # +termguicolors, unlike /usr/bin/vim
brew "neovim"
brew "pyenv"
brew "daipeihust/tap/im-select"  # vscode-vim input method switching

# ---------------------------------------------------------------------------
# CLI - good to have
# ---------------------------------------------------------------------------
brew "rlwrap"
brew "php"             # Alfred Focus & TimeZones workflows (macOS has no php)
# brew "llvm"          # clangd for coc (see nvim/coc-settings.json)
# brew "cmake"

# ---------------------------------------------------------------------------
# Apps
# ---------------------------------------------------------------------------
cask "iterm2"
cask "karabiner-elements"
cask "rectangle"
cask "alfred"
cask "visual-studio-code"
cask "google-chrome"
cask "google-drive"
cask "sogouinput"
cask "dash"
cask "iina"
cask "monodraw"
cask "notion"
cask "jetbrains-toolbox"
# cask "pdf-expert"
# cask "docker-desktop"

# ---------------------------------------------------------------------------
# Fonts
# ---------------------------------------------------------------------------
cask "font-iosevka-ss05"
