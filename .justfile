# List just commands
just:
    @just --list

# Show capture card output in mpv
[group('devices')]
cc:
    mpv av://v4l2:/dev/video0 \
        --profile=low-latency \
        --untimed \
        --demuxer-lavf-format=video4linux2 \
        --demuxer-lavf-o=video_size=1920x1080,framerate=60,input_format=yuyv422 \
        --no-audio \
        --cache=no \
        --vd-lavc-threads=1

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
