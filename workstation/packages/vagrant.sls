{% set user = salt.pillar.get('workstation:user') %}

vagrant-plugin-lxc:
  cmd.run:
    - runas: {{ user }}
    - name: vagrant plugin install vagrant-lxc
    - unless: vagrant plugin list | grep vagrant-lxc

vagrant-plugin-salt-grains:
  cmd.run:
    - runas: {{ user }}
    - name: vagrant plugin install salty-vagrant-grains
    - unless: vagrant plugin list | grep salty-vagrant-grains
