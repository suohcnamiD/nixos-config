# Intro
Hi, this is my NixOS monorepo with a flake, .nix files and dotfiles. Dotfiles are managed by `chezmoi`.

# Applying
## 1. Clone the repo into `~/nixos-config`
	```bash
	
	git clone https://github.com/suohcnamiD/nixos-config ~/nixos-config
	cd ~/nixos-config
	```

## 2. Transfer the private key
	In order for Secrets to work, you need a private SOPS key. If you had access to an old machine using this repo, copy the `~/.config/sops/age/keys.txt` file onto the new system. If not, you would have to create a new key and rewrite the SOPS yaml manually: `$ sops ~/nixos-config/secrets/secrets.yaml`. Refer to SOPS documentation for details.
	
## 3. Run NixOS rebuild (host `asus`)
	I currently only use the `asus` host which corresponds to my laptop.
	Rebuild: `sudo nixos-rebuild switch --flake .#asus`

## 4. Initialize `chezmoi`
	Run `chezmoi init --source ~/nixos-config/dotfiles` so that `chezmoi` knows where to look for dotfiles.

## 5. Apply `chezmoi`
	Run `chezmoi apply` to apply the dotfiles - now you have the whole system!
