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
