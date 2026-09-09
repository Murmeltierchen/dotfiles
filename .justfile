# List just commands
[group('general')]
just:
    @just --list

# Update dotfiles and neovim config
[group('update')]
update-config: pull-dotfiles pull-nvim

[private]
[group('update')]
[working-directory: 'dotfiles']
pull-dotfiles:
    git pull
    stow --adopt .
    git restore .

[private]
[group('update')]
[working-directory: '.config/nvim']
pull-nvim:
    git pull
