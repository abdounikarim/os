# SSH

Generate an ED25519 SSH key:

```console
ssh-keygen -t ed25519 -C "your_email@example.com"
```

Add the key to the macOS keychain:

```console
ssh-add --apple-use-keychain ~/.ssh/id_ed25519
```

Copy the public key:

```console
pbcopy < ~/.ssh/id_ed25519.pub
```

Add it to GitHub at https://github.com/settings/ssh/new.

Test the connection:

```console
ssh -T git@github.com
```

You should see: `Hi username! You've successfully authenticated, but GitHub does not provide shell access.`
