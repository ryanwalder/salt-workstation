i3wm:
  pkgrepo.managed:
    - name: deb http://debian.sur5r.net/i3/ {{ salt.grains.get('lsb_distrib_codename') }} universe
    - file: /etc/apt/sources.list.d/i3.list
    - keyid: 941C42E6
    - keyserver: keyserver.ubuntu.com
    - require_in:
      - pkg: i3wm
  pkg.latest:
    - pkgs:
      - i3wm
      - i3lock
      - xorg
