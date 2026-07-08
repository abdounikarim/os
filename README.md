# macOS Setup

Automates setting up a new Mac: Homebrew packages and casks, dotfile templates, shell configuration, and macOS system preferences — all via a single `make install`.

## Prerequisites

- macOS (Apple Silicon)
- Xcode Command Line Tools: `xcode-select --install`

## Quick start

```bash
git clone https://github.com/abdounikarim/os.git ~/os
cd ~/os
make install
```

After install, reload your shell:

```bash
source ~/.zshrc
```

## Make targets

| Target | Description |
|---|---|
| `make backup` | Snapshot current dotfiles to `~/.dotfiles_backup/<timestamp>` before overwriting |
| `make install` | Install all packages, apply dotfile templates, configure macOS preferences |
| `make update` | Upgrade all Homebrew formulae and casks |
| `make check` | Verify key tools are on PATH and config files are in place |
| `make remove` | Uninstall everything installed by `make install` |
| `make dock-save` | Save current Dock layout to `templates/com.apple.dock.plist` |
| `make dock-restore` | Restore Dock layout from `templates/com.apple.dock.plist` |

> `gmake` is an alias registered in `~/.zshrc` that runs `make` against this Makefile from anywhere in the terminal.

## What gets installed

**CLI tools** — `lsd`, `bat`, `git-delta`, `glow`, `gh`, `starship`, `gnupg`, `act`, `topgrade`, `mkcert`, `tree`, `asciinema`, `marp-cli`, `ansible`

**PHP stack** — `php`, `composer`, `symfony-cli`, `blackfire`, `xdebug` (via PECL)

**Node stack** — `node`, `pnpm`

**Casks** — Docker Desktop, Brave, Firefox, Bitwarden, iTerm2, PHPStorm, WebStorm, Insomnia, Rectangle, Slack, Claude, Claude Code, Sublime Text, SuperWhisper, The Unarchiver, Hack Nerd Font

**Shell** — Oh My Zsh, zsh-autosuggestions, zsh-fast-syntax-highlighting, zsh-vi-mode

See [`Brewfile`](Brewfile) for the full list.

## Dotfile templates

`make install` copies these templates to your home directory:

| Template | Destination |
|---|---|
| `templates/.zshrc` | `~/.zshrc` |
| `templates/.gitconfig` | `~/.gitconfig` |
| `templates/.gitignore` | `~/.gitignore` |
| `templates/starship.toml` | `~/.config/starship.toml` |
| `templates/com.googlecode.iterm2.plist` | `~/Library/Preferences/` |

## Customization

Add a `Brewfile.local` at the repo root to install machine-specific packages without modifying the tracked `Brewfile`:

```ruby
# Brewfile.local (gitignored)
brew "..."
cask "..."
```

It is picked up automatically by `make install` and `make update`.

## Additional setup

- **GPG signing** — see [`gpg.md`](gpg.md)
- **Known issues** — see [`ISSUES.md`](ISSUES.md)

## Customize a plist template

1. Copy the file from `~/Library/Preferences`
2. Convert to XML:
   ```bash
   plutil -convert xml1 com.googlecode.iterm2.plist
   ```
3. Edit and save
4. Convert back to binary:
   ```bash
   plutil -convert binary1 com.googlecode.iterm2.plist
   ```
5. Move the updated file into `templates/`
6. Run `make dock-save` / `make install` to apply
