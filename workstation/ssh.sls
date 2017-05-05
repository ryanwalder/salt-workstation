{% from "workstation/map.jinja" import workstation with context %}

# Set some common variables
{% set user = workstation.get('user') %}
{% set home = '/home/' + user %}

ssh-packages:
  pkg.latest:
    - pkgs:
      - ssh

ssh-dir:
  file.directory:
    - name: {{ home }}/.ssh
    - user: {{ user }}
    - mode: 700
