# Install your OSX tools

## Install tools
```bash
make install
```

## Update tools
```bash
make update
```

## Configure Github or Gitlab SSH access
Generate an ssh key locally :
```bash
ssh-keygen -t rsa -C "email@example.com"
```

Show public key :
```bash
cat ~/.ssh/id_rsa.pub
```

Add this key in Github or Gitlab

## Synchronise Brave

## Synchronise PHPStorm

## Remove tools

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
