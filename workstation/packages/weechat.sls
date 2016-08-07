{%- from 'workstation/map.jinja' import workstation with context %}

{%- set user = workstation.get('user') %}
{%- set home = workstation.get('home') %}

weechat:
  pkg.latest:
    - pkgs:
      - weechat-curses
      - weechat-plugins
      - weechat-scripts
  file.directory:
    - name: {{ home }}/.weechat
    - user: {{ user }}
    - mode: 700
    - require:
      - pkg: weechat

weechat-buffers:
  cmd.run:
    - name: curl -LSso {{ home }}/.weechat/perl/autoload/buffers.pl https://weechat.org/files/scripts/buffers.pl
    - file: {{ user }}
    - require:
      - pkg: weechat

weechat-buffer-sort:
  cmd.run:
    - name: curl -LSso {{ home }}/.weechat/python/autoload/autosort.py https://weechat.org/files/scripts/autosort.py
    - user: {{ user }}
    - require:
      - file: weechat
