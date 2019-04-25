{%- from 'workstation/map.jinja' import workstation with context %}
{%- from 'workstation/dotfiles.jinja' import dotfiles with context %}

{%- set user = workstation.get('user') %}
{%- set group = workstation.get('user') %}
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
    - force_clone: False
    - force_reset: False


{%- for dir, details in dotfiles.items() %}
dotfiles-dir-{{ dir|replace('/', '-') }}:
  file.directory:
    - name: {{ home }}/{{ details.get('path', dir) }}
    - user: {{ details.get('user', user) }}
    - group: {{ details.get('group', group) }}
    - mode: {{ details.get('mode', '755') }}
    - makedirs: True
    - force: True

  {%- for name, file in details.files.items() %}
dotfiles-symlink-{{ dir|replace('/', '-') }}-{{ name }}:
  file.symlink:
    - name: {{ home }}/{{ dir }}/{{ name }}
    - target: {{ home }}/{{ file.source }}
    - force: True
    - makedirs: True
    - user: {{ user }}
    - require:
      - file: dotfiles-dir-{{ dir|replace('/', '-') }}
  {% endfor %}
{% endfor %}
