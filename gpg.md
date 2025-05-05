# GPG

Copy your gpg folder `~/.gnupg` and paste it in `~/.gnupg`.

```console
brew install gpg
```

```console
brew install pinentry-mac
```

Create a file `~/.gnupg/gpg-agent.conf` with the following content:

```conf
pinentry-program /opt/homebrew/bin/pinentry-mac
```

List your keys:

```console
gpg --list-keys
```

Kill gpg-agent:

```console
pkill -TERM gpg-agent
```

Restart your terminal.

Check that gpg works:

```console
echo "test" | gpg --clearsign
```

Save the key to your keychain 🔐
