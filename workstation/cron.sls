{%- from 'workstation/map.jinja' import workstation with context %}

{%- set user = workstation.get('user') %}
{%- set home = workstation.get('home') %}

cron-wallpaper:
  cron.present:
    - name: '~/bin/wallpaper'
    - user: {{ user }}
    - minute: '*/10'
