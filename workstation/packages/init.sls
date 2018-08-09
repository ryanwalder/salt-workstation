include:
  - workstation.packages.vagrant

workstation-packages:
  pkg.latest:
    - pkgs:
      - alsa-utils
      - autorandr
      - bridge-utils
      - build-essential
      - chromium-browser
      - curl
      - feh
      - firefox
      - flashplugin-installer
      - gcc
      - gnome-keyring
      - gnome-terminal
      - gthumb
      - haveged
      - htop
      - jq
      - libreoffice
      - lxc
      - lxd
      - mtr
      - net-tools
      - nmap
      - pinta
      - playerctl
      - python
      - python-dev
      - python-pip
      - python3-dev
      - python3-pip
      - rsync
      - ruby
      - ruby-dev
      - screen
      - scrot
      - ssh
      - suckless-tools
      - sudo
      - thunar
      - thunderbird
      - tmux
      - vim
      - vlc
      - w3m
      - wget
      - wicd-curses
      - xclip
      - xclip
      - xdg-utils
      - xfonts-terminus
    - refresh: True

workstation-packages-purged:
  pkg.purged:
    - pkgs:
      - nano
