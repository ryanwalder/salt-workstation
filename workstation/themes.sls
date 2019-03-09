workstation-themes-papirus:
  pkgrepo.managed:
    - ppa: papirus/papirus
  pkg.latest:
    - pkgs:
      - papirus-icon-theme
      - papirus-folders
    - refresh: True
  cmd.run:
    - name: papirus-folders -C blue --theme Papirus-Dark
    - unless: papirus-folders -l --theme Papirus-Dark | grep ">" | awk '{print $2}' | grep blue

workstations-theme-arc:
  pkg.latest:
    - name: arc-theme
    - refresh: True
