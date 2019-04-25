include:
  - workstation.i3
  - workstation.dotfiles
  - workstation.packages
  - workstation.cron
  {%- if salt['cmd.retcode']('grep Battery /sys/class/power_supply/*/type', python_shell=True) == 0 %}
  - workstation.laptop
  {%- endif %}
