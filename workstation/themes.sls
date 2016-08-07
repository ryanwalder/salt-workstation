theme-mediterranean:
  pkgrepo.managed:
    - humanname: Noobslab Themes
    - name: deb http://ppa.launchpad.net/noobslab/themes/ubuntu trusty main
    - file: /etc/apt/sources.list.d/noobslab-themes-trusty.list
    - keyid: F59EAE4D
    - keyserver: keyserver.ubuntu.com
  pkg.latest:
    - name: mediterranean-theme
    - refresh: True

icons-faenza:
  pkgrepo.managed:
    - humanname: Noobslab Themes
    - name: deb http://ppa.launchpad.net/noobslab/icons/ubuntu trusty main
    - file: /etc/apt/sources.list.d/noobslab-icons-trusty.list
    - keyid: F59EAE4D
    - keyserver: keyserver.ubuntu.com
  pkg.latest:
    - name: faenza-icon-theme
    - refresh: True
