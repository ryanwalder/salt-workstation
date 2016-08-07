{%- from 'workstation/map.jinja' import workstation with context %}

{%- set user = workstation.get('user') %}
{%- set home = workstation.get('home') %}

dotfiles:
  git.latest:
    - name: https://github.com/ryanwalder/dotfiles.git
    - target: {{ home }}/.dotfiles
    - user: {{ user }}

# Setup directories, will create preceding dirs if needed
{% for dir, mode in {
  ".gconf/apps/gnome-terminal/profiles/Default": "755",
  ".fonts": "755",
  ".mcabber": "755",
  ".i3": "755",
  ".config/gtk-3.0": "755"
}.items() %}

dotfiles-dir-{{ dir }}:
  file.directory:
    - name: {{ home }}/{{ dir }}
    - mode: {{ mode }}
    - makedirs: True
    - require:
      - git: dotfiles
{% endfor %}

# Loopover config files and symlink, will force overwrite
{% for source, target in {
  ".dotfiles/bash/bashrc": ".bashrc",
  ".dotfiles/bash/bash_aliases": ".bashrc_aliases",
  ".dotfiles/bash/bash_logout": ".bash_logout",
  ".dotfiles/bash/bash_profile": ".bash_profile",
  ".dotfiles/bash/bash_prompt": ".bash_prompt",
  ".dotfiles/terminal/gnomedefault.xml": ".gconf/apps/gnome-terminal/profiles/Default/%gconf.xml",
  ".dotfiles/fonts/fonts.conf": ".fonts.conf",
  ".dotfiles/fonts/PowerlineSymbols.otf": ".fonts/PowerlineSymbols.otf",
  ".dotfiles/i3/config": ".i3/config",
  ".dotfiles/i3/conky-i3bar": ".i3/conky-i3bar",
  ".dotfiles/i3/conkyrc": ".i3/conkyrc",
  ".dotfiles/gtk/gtk2": ".gtkrc-2.0",
  ".dotfiles/gtk/gtk3": ".config/gtk-3.0/settings.ini"
}.items() %}

symlink-{{ target }}:
  file.symlink:
    - name: {{ home }}/{{ source }}
    - target: {{ home }}/{{ target }}
    - force: True
    - require:
      - git: dotfiles
{% endfor %}
