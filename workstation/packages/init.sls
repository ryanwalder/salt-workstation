include:
  - workstation.packages.vagrant

workstation-packages:
  pkg.latest:
    - pkgs:
      - alsa-utils
      - chromium-browser
      - feh
      - firefox
      - flashplugin-installer
      - glances
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
      - ssh
      - suckless-tools
      - sudo
      - thunar
      - thunderbird
      - tmux
      - vim
      - w3m
      - xclip
      - xfce4-terminal
      - xfonts-terminus
    - refresh: True

workstation-arc-theme:
  pkgrepo.managed:
    - name: deb http://download.opensuse.org/repositories/home:/Horst3180/xUbuntu_16.04/ /
    - file: /etc/apt/sources.list.d/arc-theme.list
    - key_url: http://download.opensuse.org/repositories/home:/Horst3180/xUbuntu_16.04/Release.key
  pkg.latest:
    - name: arc-theme
    - require:
      - pkgrepo: workstation-arc-theme

workstation-packages-purged:
  pkg.purged:
    - pkgs:
      - nano
