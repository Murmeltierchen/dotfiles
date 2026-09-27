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

[group('update')]
[private]
[working-directory('dotfiles')]
pull-dotfiles:
    git pull
    stow --adopt .
    git restore .

[group('update')]
[private]
[working-directory('.config/nvim')]
pull-nvim:
    git pull

# Add a Wireguard VPN connection to NetworkManager
[group('vpn')]
vpn-add conf name=file_stem(conf):
    #!/usr/bin/env bash
    set -euo pipefail
    tmp_dir="$(mktemp -d)"
    trap 'rm -rf "$tmp_dir"' EXIT
    cp "{{ conf }}" "$tmp_dir/{{ name }}.conf"
    nmcli connection import type wireguard file "$tmp_dir/{{ name }}.conf"
    nmcli connection modify "{{ name }}" connection.autoconnect no

# Remove a Wireguard VPN connection from NetworkManager
[group('vpn')]
vpn-remove name:
    #!/usr/bin/env bash
    set -euo pipefail
    conn="{{ file_stem(name) }}"
    if [[ "$(nmcli -g connection.type connection show id "$conn" 2>/dev/null)" != "wireguard" ]]; then
        exit 1
    fi
    nmcli connection delete id "$conn"
