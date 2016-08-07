{%- from 'workstation/map.jinja' import workstation with context %}

{%- set user = workstation.get('user') %}
{%- set home = workstation.get('home') %}

vim-dir:
  file.directory:
    - name: {{ home }}/.vim
    - user: {{ user }}
    - require:
      - sls: workstation.dotfiles{{ home }}ryan-vimrc:
  file.symlink:
    - name: {{ home }}/.vimrc
    - target: {{ home }}/.dotfiles/vim/vimrc
    - require:
      - sls: workstation.dotfiles
    - require_in:
      - cmd: vim-pathogen

{% for dir in ['bundle', 'autoload', '.swap', '.tmp', '.undo'] %}
vim-confdir-{{ dir }}:
  file.directory:
    - name: {{ home }}/.vim/{{ dir }}
    - user: {{ user }}
    - mode: 755
    - require:
      - sls: workstation.dotfiles
    - require_in:
      - cmd: vim-pathogen
{% endfor %}

# Have to use cmd.run to wget the file as salt is erroring out on file.managed
vim-pathogen:
  cmd.run:
    - name: curl -LSso {{ home }}/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
    - user: {{ user }}
    - require:
      - sls: workstation.dotfiles

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
    - user: {{ home }}
    - force: True
    - require:
      - sls: workstation.dotfiles
      - cmd: vim-pathogen
{% endfor %}
