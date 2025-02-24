# Nixos Unstable Configuration

## Sops-nix

The sops-nix configuration is made to be editable with a yubikey, but requires a local age key for nix to access it during builds.
A public age key derived from `/etc/ssh/ssh_host_ed25519_key` is as such required, and should be added to `.sops.yaml`.
The secrets file should then be re-encrypted with the updated keys, before the final rebuild to actually apply the secret values.

```sh
# In .nixos-unstable
nix-shell -p ssh-to-age --run 'cat /etc/ssh/ssh_host_ed25519_key.pub | ssh-to-age'
sops updatekeys secrets/secrets.yaml
```
