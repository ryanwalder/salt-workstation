{%- from 'workstation/map.jinja' import workstation with context %}

include:
  - workstation.dotfiles

{%- set user  = workstation.get('user') %}
{%- set home  = workstation.get('home') %}
{%- set nvim  = home + '/.config/nvim' %}
{%- set cache = home + '/.cache/nvim' %}

{% for dir in ['swap', 'tmp', 'undo'] %}
workstation-neovim-dir-{{ dir }}:
  file.directory:
    - name: {{ cache }}/{{ dir }}
    - user: {{ user }}
    - mode: 755
    - makedirs: True
    - require:
      - sls: workstation.dotfiles
{% endfor %}

workstation-neovim-confdir-symlink:
  file.symlink:
    - name: {{ nvim }}
    - target: {{ home }}/.config/dotfiles/neovim
    - require:
      - sls: workstation.dotfiles
