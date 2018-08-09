{%- from 'lightdm/map.jinja' import lightdm with context %}

lightdm:
  pkg.latest:
    - pkgs:
      {%- for pkg in lightdm.lookup.get('packages') %}
      - {{ pkg }}
      {%- endfor %}
  file.managed:
    - name: /etc/lightdm/lightdm.conf
    - source: salt://lightdm/files/lightdm.conf.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - context:
      lightdm: {{ lightdm.get('lightdm_config') }}
    - require:
      - pkg: lightdm

lightdm-gtk-conf:
  file.managed:
    - name: /etc/lightdm/lightdm-gtk-greeter.conf
    - source: salt://lightdm/files/lightdm-gtk-greeter.conf.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - context:
      lightdm: {{ lightdm.get('gtk_config') }}
    - require:
      - pkg: lightdm
