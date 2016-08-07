{% from "workstation/map.jinja" import workstation with context %}

git:
  pkg.latest:
    - pkgs:
      - git-core

## Set up git config values
# Grab the user/email from pillar for [user] section in gitconfig
{% for k, v in {
  "name": workstation.get('fullname'),
  "email": workstation.get('email')
}.items() %}

git-config-user-{{ k }}:
  git.config:
    - user: {{ name }}
    - name: user.{{ k }}
    - value: {{ v }}
    - is_global: True
    - require:
      - pkg: git
{% endfor %}

# For other sections loop over values in workstation:git:config
{% for name, section in workstation.get('git:config').items() %}
  {% for config, value in section.items() %}

git-config-{{ name }}-{{ config }}:
  git.config:
    - user: {{ workstation.get('user') }}
    - name: {{ name }}.{{ config }}
    - value: {{ value }}
    - is_global: True
    - require:
      - pkg: git

  {% endfor %}
{% endfor %}
