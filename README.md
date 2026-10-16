# My Minimal Standalone Nix Configuration

This repository contains a collection of `.nix` files which define the minimal configuration for a
PC. The files are designed to be used with the package manager
[Nix](https://en.wikipedia.org/wiki/Nix_(package_manager)) in conjunction with
[Home-Manager (HM)](https://nix-community.github.io/home-manager/). The configuration assumes that
Nix/HM are running in a non-[NixOS](https://en.wikipedia.org/wiki/NixOS) Linux system.

## Set up Steps

The following are the steps needed to derive the Nix configuration on a fresh Linux install. We
assume that Nix is not already installed.  

### 1. Install Nix

To make the installation as quick and painless as we can, we will use the
[Determinate Systems (DS)](https://docs.determinate.systems/determinate-nix/) installer

>[!note]
>
> There is some ... disagreement ... in the Nix community about DS. For us the key pain point is
> [flakes](https://nixos.wiki/wiki/flakes) which
> [DS has stabilized](https://determinate.systems/blog/determinate-nix-30/) despite upstream Nix
> listing the feature as experimental.

```sh
curl -fsSL https://install.determinate.systems/nix | sh -s -- install
```

### 2. Pull Some Git Repositories

#### This Repository

Clone this repository into the root of the home directory.

```sh
git clone https://github.com/Joecstarr/mmsnc.git ~/mmsnc/
```

#### This Neovim Configuration

Clone the repository containing the separate [Neovim](https://neovim.io/) configuration into the
`~/.config/nvim/` directory.

>[!note]
>
> We could maintain the Neovim configuration with nix expressions with a tool like
> [nixvim](https://nix-community.github.io/nixvim/). I choose to do it this way to make the
> configuration portable to windows.  

```sh
git clone https://github.com/Joecstarr/nvim_config.git ~/.config/nvim/
```

### 3. Install NixGL

We're going to manage the desktop environment with [Hyprland](https://wiki.hypr.land/). When using
Hyprland with standalone Nix we need to supply graphics drivers.

```sh
sudo nix profile add github:guibou/nixGL --impure
```

### 4. Derive the Configuration

#### First Run Enable HM

Our system has Nix but now HM. To use HM we will need to bring it onto our path in the current
shell. To do this we can run the following:

```sh
nix shell github:nix-community/home-manager
```

After the first time we build the environment HM will always be in the Nix store so we won't need to
specifically add it to the shell.

#### HM Switch

From inside the `mmsnc` directory run the following to switch to the HM managed environment. It's
probably a good idea to restart the machine at this point.

>[!warning]
>
> HM can only manage files in the `$HOME` directory. Meaning if we want to manage system level files
> (I'm not sure that this is really a good idea) we need an alternative strategy.
> 
> We will maintain `~/rootMirror/` as a mirror of the system level files we want to manage. We will
> then symlink those files at the end of a HM switch. This is done with a number of scripts some of
> which will require `sudo` permissions.  

```sh
home-manager switch --flake .
```

>[!note]
>
> We can run the command from anywhere just point HM at the right location.

#### Updates

Since we're using Nix flakes we can update our package/module references by running:

```sh
nix flake update
```
