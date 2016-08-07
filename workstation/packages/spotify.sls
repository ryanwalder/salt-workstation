spotify:
  pkgrepo.managed:
    - file: /etc/apt/sources.list.d/spotify.list
    - name: deb http://repository.spotify.com stable non-free
    - keyid: D2C19886
    - keyserver: keyserver.ubuntu.com
  pkg.latest:
    - pkgs:
      - spotify-client
    - require:
      - pkgrepo: spotify
