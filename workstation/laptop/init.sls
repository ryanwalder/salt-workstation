laptop-packages:
  pkg.latest:
    - pkgs:
      - laptop-mode-tools
  file.managed:
    - name: /etc/laptop-mode/laptop-mode.conf
    - source: salt://workstation/laptop/files/laptop-mode.conf.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - context:
      - laptop: {{ workstation.laptop-mode.config }}
