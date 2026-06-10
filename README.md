# Intro
Hi, this is my NixOS monorepo with a flake, .nix files and dotfiles. Dotfiles are managed by `chezmoi`.

# Applying
## 1. Clone the repo into `~/nixos-config`
	
	git clone https://github.com/suohcnamiD/nixos-config ~/nixos-config
	cd ~/nixos-config
	

## 2. Transfer the private key
In order for Secrets to work, you need a private SOPS key. 

If you had access to an old machine using this repo, copy the `~/.config/sops/age/keys.txt` file onto the new system. 

If not, you would have to create a new key and rewrite the SOPS yaml manually: 

	sops ~/nixos-config/secrets/secrets.yaml 

Refer to SOPS documentation for details.
	
## 3. Run NixOS rebuild (host `asus`)
I currently only use the `asus` host which corresponds to my laptop.

Rebuild: 

	sudo nixos-rebuild switch --flake .#asus

## 4. Initialize `chezmoi`
Run this so that `chezmoi` knows where to look for dotfiles:

	 chezmoi init --source ~/nixos-config/dotfiles

## 5. Apply `chezmoi`
Run this to apply the dotfiles:

	chezmoi apply

Now you have the whole system!

# Adding dotfiles
Use `chezmoi` to add new dotfiles: 

    chezmoi add ~/.config/something/myfile.json
    
Don't forget to stage and commit the new file that `chezmoi` generates for you under `~/.local/...` (the full path does not matter).

# Editing dotfiles
Use `chezmoi edit` for first-class dotfile edit support:

	chezmoi edit ~/.config/something/myfile.json

Commit and push afterwards.

If you want to just persist your current system changes of a file into the chezmoi repo, just use `chezmoi add` on it again. If the file is a template, you have to use `chezmoi merge` though - refer to chezmoi docs.
