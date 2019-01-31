# Dotfiles

## bash files
```
~/.bash_profile
       The personal initialization file, executed for login shells
~/.bashrc
       The individual per-interactive-shell startup file
~/.bash_logout
       The individual login shell cleanup file, executed when a login shell exits
~/.inputrc
       Individual readline initialization file
```

## Midnight Commander
```sh
cd ~/.config/mc
ln -s DOTFILES/mc/ini .
```
### Fix issue with inputrc
From man
> bash users may specify startup commands in ~/.local/share/mc/bashrc (fallback ~/.bashrc) and special keyboard maps in ~/.local/share/mc/inputrc (fallback ~/.inputrc).

```
cd ~/.local/share/mc/
touch inputrc
```
