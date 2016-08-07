include:
  - workstation.packages.i3
  - workstation.packages.lightdm
  - workstation.packages.spotify
  - workstation.packages.weechat
#  - workstation.packages.vagrant

workstation-packages:
  pkg.latest:
    - pkgs:
      - alsa-utils
      - feh
      - firefox
      - flashplugin-installer
      - fortunes-bofh-excuses
      - glances
      - gnome-terminal
      - gthumb
      - haveged
      - htop
      - libreoffice
      - mtr
      - nmap
      - python
      - python-pip
      - python-software-properties
      - rsync
      - screen
      - suckless-tools
      - sudo
      - thunar
      - thunderbird
      - tmux
      - tumbler
      - vim
      - w3m
      - weechat
      - weechat-curses
      - weechat-plugins
      - weechat-scripts
      - xclip
      - xfonts-terminus
    - refresh: True

workstation-packages-purged:
  pkg.purged:
    - pkgs:
      - nano
