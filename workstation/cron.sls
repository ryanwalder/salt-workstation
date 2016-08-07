{%- from 'workstation/map.jinja' import workstation with context %}

{%- set user = workstation.get('user') %}
{%- set home = workstation.get('home') %}

cron-wallpaper:
  cron.present:
    - name: 'DISPLAY=:0.0 feh --bg-max "$(find ~/wallpapers/|shuf -n1)"'
    - user: {{ user }}
    - minute: '*/10'
