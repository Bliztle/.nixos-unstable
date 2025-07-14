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

## Setting Up New Hosts

### 0) Clone This Repository

```sh
nix-shell -p git --command 'git clone https://github.com/Bliztle/.nixos-unstable'
```

### 1) Create host configuration

Add a new host configuration in `./hosts` for the machine. 
Make sure to copy `/etc/nixos/hardware-configuration.nix` to this directory.
At minimum, the host configuration should consist of the following:

- `options.nix` setting custom options for this host
- `hardware-configuration.nix` defining hardware layout
- `default.nix` importing the previous files

#### 1.1) First System Build

Now build the system to enable most modules and ease further setup. 
It is technically possible to continue without this step, but I do not recommend it.

```sh
sudo nixos-rebuild switch --flake .#<hostname>
```

> [!WARN]
> `nixos-rebuild` will report an error regarding sops age keys.
> This is fixed in step 3 of this guide.
> The rest of the system should still work however.

### 2) Yubikey Setup

Yubikey identifiers are specific to each machine, so they need to be regenerated after a new install.

```sh
mkdir -p ~/.config/Yubico
# First key
pamu2fcfg > ~/.config/Yubico/u2f_keys
# Second key
pamu2fcfg >> ~/.config/Yubico/u2f_keys
```

#### 2.1) Importing GPG Keys

From the root of this repository, import the GPG key used as follows:

```sh
gpg --import pubkey.asc
```

And trust the key
```sh
# Replace this with your key id
gpg --edit-key 92810374E3AC1EE1 
```
- 


### 3) Add Sops Key

> [!NOTE]
> The following step requires a yubikey already registered with sops, to edit the registered keys.
> The current setup edits sops files with the yubikey's GPG key, 
> and uses the age key registered in the steps below to read the secrets at build time.
> It thus requires the GPG key to already be imported, as outlined in step 2.
> If you are reading this as inspiration for your own setup, this can safely be ignored.

First check if an ssh host key already exists. Look for `/etc/ssh/ssh_host_<key type>` 
and `/etc/ssh/ssh_host_<key type>.pub`. If none exists, generate a new one:

```sh
sudo ssh-keygen -t ed25519 -a 32 -f /etc/ssh/ssh_host_ed25519`
```

Then register the key with sops by copying the output of the following command to .sops.yaml

```sh
nix-shell -p ssh-to-age --run 'cat /etc/ssh/ssh_host_ed25519_key.pub | ssh-to-age'
```

and telling sops to update the keys

```sh
# In .nixos-unstable
sops updatekeys secrets/secrets.yaml
```
