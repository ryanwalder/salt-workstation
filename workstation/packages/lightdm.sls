lightdm:
  pkg.latest:
    - pkgs:
      - lightdm
      - lightdm-gtk-greeter
  file.managed:
    - name: /etc/lightdm/lightdm.conf
    - source: salt://lightdm/files/lightdm.conf
    - user: root
    - group: root
    - mode: 644
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
      lightdm: {{ lightdm }}
    - require_in:
      - pkg: lightdm
