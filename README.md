# Install your Mac OS tools

Tools are grouped into packages under `packages/`: `common`, `git`, `zsh`,
`php`, `js`, `ruby`, `python`, `cleaner`. Each `.mk` file installs its
Homebrew formulae/casks and applies that package's own configuration
(dotfiles, Xdebug, Blackfire, PhpStorm plugins, app quarantine removal, etc.)
in one place. `ruby` and `python` are currently empty stubs.

## Install tools

```bash
make install          # every package
make php-install       # a single package
```

## Update tools

```bash
gmake update            # every package
gmake php-update        # a single package
```
_You can run `gmake` from anywhere in your terminal._

## Remove tools

```bash
make remove             # every package, plus Homebrew itself
make php-remove         # a single package's brews/casks only
```

## zsh plugins

All plugins in `templates/.zshrc` load through a single mechanism: the
`plugins=(...)` array, read by `source $ZSH/oh-my-zsh.sh`. Two kinds of
entries live in there:

- **Bundled with oh-my-zsh**: `git`, `docker`, `docker-compose`, `composer`,
  `symfony`, `macos`, `brew`, `history-substring-search`.
- **Custom plugins** (`zsh-autosuggestions`, `zsh-vi-mode`,
  `fast-syntax-highlighting`) — not bundled with oh-my-zsh, so `packages/zsh.mk`
  git-clones them straight into `$ZSH_CUSTOM/plugins/<name>/` instead of
  installing them via Homebrew. oh-my-zsh's loader only picks up a plugin if
  it finds a file at `$ZSH_CUSTOM/plugins/<name>/<name>.plugin.zsh`, so each
  clone's directory name has to match its own plugin file — that's why the
  third one is named `fast-syntax-highlighting` here rather than the
  `zsh-fast-syntax-highlighting` Homebrew formula name it used to have.

See the [oh-my-zsh Customization wiki](https://github.com/ohmyzsh/ohmyzsh/wiki/Customization)
for how `$ZSH_CUSTOM` and the `plugins=()` array work.

## Customize .plist file

1. Copy the file you want from `~/Library/Preferences`
2. Convert the file to be readable by your text editor :
```bash
plutil -convert xml1 com.googlecode.iterm2.plist
```
3. Make changes in your editor and save
4. Convert the file into binary
```bash
plutil -convert binary1 com.googlecode.iterm2.plist
```
5. Copy the updated file into `~/Library/Preferences`
6. Relaunch your application and show your new configuration
