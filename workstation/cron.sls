{%- from 'workstation/map.jinja' import workstation with context %}

{%- set user = workstation.get('user') %}
{%- set home = workstation.get('home') %}

cron-wallpaper:
  cron.present:
    - name: 'DISPLAY=:0 ~/bin/wallpaper'
    - user: {{ user }}
    - minute: '*/10'
    - identifier: WALLPAPER
