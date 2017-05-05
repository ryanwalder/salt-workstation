{%- from 'workstation/map.jinja' import workstation with context %}

include:
  - workstation.dotfiles

{%- set user = workstation.get('user') %}
{%- set home = workstation.get('home') %}

{% for dir in ['bundle', 'autoload', '.swap', '.tmp', '.undo'] %}
vim-confdir-{{ dir }}:
  file.directory:
    - name: {{ home }}/.vim/{{ dir }}
    - user: {{ user }}
    - mode: 755
    - makedirs: True
    - require:
      - sls: workstation.dotfiles
{% endfor %}

vim-pathogen:
  git.latest:
    - name: https://github.com/tpope/vim-pathogen
    - target: {{ home }}/.vim/pathogen
    - user: {{ user }}
    - force_clone: True
    - force_reset: True
    - require:
      - file: vim-confdir-bundle
  file.symlink:
    - name: {{ home }}/.vim/autoload/pathogen.vim
    - target: {{ home }}/.vim/pathogen/autoload/pathogen.vim
    - user: {{ user }}
    - require:
      - file: vim-confdir-bundle
      - git: vim-pathogen

{% for repo, folder in {
  "https://github.com/godlygeek/tabular.git": "tabular",
  "https://github.com/tpope/vim-fugitive.git": "fugitive",
  "https://github.com/tpope/vim-speeddating.git": "speeddating",
  "https://github.com/bling/vim-airline.git": "airline",
  "https://github.com/saltstack/salt-vim.git": "salt-syntax",
  "https://github.com/rodjek/vim-puppet.git": "puppet-syntax",
  "https://github.com/ntpeters/vim-better-whitespace.git": "better-whitespace",
  "https://github.com/Glench/Vim-Jinja2-Syntax.git": "jinja2-syntax",
  "https://github.com/ekalinin/Dockerfile.vim.git": "dockerfile-syntax",
  "https://github.com/plasticboy/vim-markdown.git": "markdown-syntax",
  "https://github.com/markcornick/vim-terraform.git": "terraform-syntax",
}.items() %}

workstation-users-ryan-vim-{{ repo }}:
  git.latest:
    - name: {{ repo }}
    - target: {{ home }}/.vim/bundle/{{ folder }}
    - user: {{ user }}
    - branch: master
    - force_clone: True
    - force_reset: True
    - require:
      - sls: workstation.dotfiles
      - file: vim-pathogen
{% endfor %}

vim-symlink:
  file.symlink:
    - name: {{ home }}/.vimrc
    - target: {{ home }}/.config/dotfiles/vim/vimrc
    - require:
      - sls: workstation.dotfiles
    - require_in:
      - file: vim-pathogen
