{% from "workstation/map.jinja" import workstation with context %}

# Set some common variables
{% set user = workstation.get('username') %}
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

ssh-config:
  file.managed:
    - name: {{ home }}/.ssh
    - source: salt://workstation/files/ssh.config
    - user: {{ user }}
    - mode: 600
