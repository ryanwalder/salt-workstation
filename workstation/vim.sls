{%- from 'workstation/map.jinja' import workstation with context %}

include:
  - workstation.dotfiles

{%- set user = workstation.get('user') %}
{%- set home = workstation.get('home') %}

{% for dir in ['bundle', 'autoload', '.swap', '.tmp', '.undo'] %}
workstation-vim-confdir-{{ dir }}:
  file.directory:
    - name: {{ home }}/.vim/{{ dir }}
    - user: {{ user }}
    - mode: 755
    - makedirs: True
    - require:
      - sls: workstation.dotfiles
{% endfor %}

workstation-vim-pathogen:
  git.latest:
    - name: https://github.com/tpope/vim-pathogen
    - target: {{ home }}/.vim/pathogen
    - user: {{ user }}
    - force_clone: True
    - force_reset: True
    - require:
      - file: workstation-vim-confdir-bundle
  file.symlink:
    - name: {{ home }}/.vim/autoload/pathogen.vim
    - target: {{ home }}/.vim/pathogen/autoload/pathogen.vim
    - user: {{ user }}
    - require:
      - file: workstation-vim-confdir-bundle
      - git: workstation-vim-pathogen

{% for repo in [
  "https://github.com/godlygeek/tabular.git",
  "https://github.com/tpope/vim-fugitive.git",
  "https://github.com/tpope/vim-speeddating.git",
  "https://github.com/bling/vim-airline.git",
  "https://github.com/saltstack/salt-vim.git",
  "https://github.com/rodjek/vim-puppet.git",
  "https://github.com/ntpeters/vim-better-whitespace.git",
  "https://github.com/Glench/Vim-Jinja2-Syntax.git",
  "https://github.com/ekalinin/Dockerfile.vim.git",
  "https://github.com/plasticboy/vim-markdown.git",
  "https://github.com/markcornick/vim-terraform.git",
  "https://github.com/martinda/Jenkinsfile-vim-syntax",
] %}

workstation-vim-plugin-{{ repo.split('/')[-1]|replace('.git', '') }}:
  git.latest:
    - name: {{ repo }}
    - target: {{ home }}/.vim/bundle/{{ repo.split('/')[-1]|replace('.git', '') }}
    - user: {{ user }}
    - branch: master
    - force_clone: True
    - force_reset: True
    - require:
      - sls: workstation.dotfiles
      - file: workstation-vim-pathogen
{% endfor %}

workstation-vim-symlink:
  file.symlink:
    - name: {{ home }}/.vimrc
    - target: {{ home }}/.config/dotfiles/vim/vimrc
    - require:
      - sls: workstation.dotfiles
    - require_in:
      - file: workstation-vim-pathogen
