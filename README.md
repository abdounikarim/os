# Install your Mac OS tools

## Install tools

Install Task
```
sudo sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d -b /usr/local/bin
```

```bash
task install
```

If you want to use gpg to sign your git commits, check the [GPG](./gpg.md) section.

## Update tools
```bash
gtask update
```
_You can run `gtask` from anywhere in your terminal._

## Remove tools

```bash
task uninstall
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
