# dotfiles
## Installation

First, check out the dotfiles repo in your $HOME directory using git

```sh
git clone https://github.com/Murmeltierchen/dotfiles.git $HOME/dotfiles
cd $HOME/dotfiles
```

Then use GNU stow to create symlinks

```sh
stow .
```

If you have to overwrite existing files, use

```sh
stow --adopt .
git restore .
```

More in the [YouTube-Tutorial](https://www.youtube.com/watch?v=y6XCebnB9gs)
