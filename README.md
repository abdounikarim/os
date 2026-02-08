# Install your Mac OS tools

## Install tools

```bash
make install
```

## Update tools

```bash
gmake update
```
_You can run `gmake` from anywhere in your terminal._

## Remove tools

```bash
make remove
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
