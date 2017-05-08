{%- from 'workstation/map.jinja' import workstation with context %}

{%- set user = workstation.get('user') %}
{%- set home = workstation.get('home') %}

dotfiles-parent-dir:
  file.directory:
    - name: {{ home }}/.config
    - user: {{ user }}

dotfiles:
  git.latest:
    - name: https://github.com/ryanwalder/dotfiles.git
    - target: {{ home }}/.config/dotfiles
    - user: {{ user }}
    - force_clone: True
    - force_reset: True

# Loopover config files and symlink, will force overwrite
{% for source, target in {
  ".config/dotfiles/bash/bashrc": ".bashrc",
  ".config/dotfiles/bash/inputrc": ".inputrc",
  ".config/dotfiles/terminal/Xresources": ".Xresources",
  ".config/dotfiles/git/gitconfig": ".gitconfig",
  ".config/dotfiles/fonts/fonts.conf": ".config/fontconfig/fonts.conf",
  ".config/dotfiles/i3/config": ".i3/config",
  ".config/dotfiles/gtk/gtk2": ".gtkrc-2.0",
  ".config/dotfiles/gtk/gtk3": ".config/gtk-3.0/settings.ini"
}.items() %}

dotfiles-symlink-{{ target|replace('/', '-') }}:
  file.symlink:
    - name: {{ home }}/{{ target }}
    - target: {{ home }}/{{ source }}
    - force: True
    - makedirs: True
    - user: {{ user }}
    - require:
      - git: dotfiles
{% endfor %}
