# Dots

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/). Each top-level folder is a
Stow package that mirrors `$HOME`.

| Package  | Links                       |
|----------|-----------------------------|
| `zsh`    | `~/.zshrc`, `~/.p10k.zsh`   |
| `kitty`  | `~/.config/kitty`           |
| `nvim`   | `~/.config/nvim`            |
| `zellij` | `~/.config/zellij`          |

## New machine

```bash
git clone git@github.com:AlessandroRLM/Dots.git ~/Dots
~/Dots/install
```

`install` is idempotent and runs, in order:

1. Fedora only: copies `fedora/repos/*.repo` to `/etc/yum.repos.d/`, installs `fedora/packages.txt` with dnf,
   enables Docker and adds `$USER` to the `docker` group (log out and back in afterwards), and adds Flathub.
2. Installs Homebrew if missing.
3. Installs everything missing from the `Brewfile` (`brew bundle`).
4. Fedora only: installs the latest Bruno `.rpm` from GitHub releases if `bruno` is not installed.
   Bruno updates itself afterwards.
5. Restows every package.

Stow refuses to overwrite real files: move any existing `~/.zshrc` or `~/.config/<tool>` out of the way first.

Link a subset with `STOW_FOLDERS=zsh,nvim ~/Dots/install`.

## Daily use

- Files in `$HOME` are symlinks into this repo, so edits land here directly. Commit and push them.
- New shells print a yellow warning when `~/Dots` has uncommitted or unpushed changes.
- After installing a Homebrew package you want everywhere, run `brew bundle dump --file=~/Dots/Brewfile --force`
  and re-add `brew "stow"` if it disappears.
- On another machine: `git -C ~/Dots pull && ~/Dots/install`.
