workstation:
  username: ryan
  home: /home/ryan
  fullname: Ryan Walder
  email: ryan.walder@gmail.com

lightdm:
  lightdm_config:
    {%- if salt.grains.get('productname') == 'XPS 15 9550' %}
    xserver-command: X -dpi 220
    {%- endif %}
    greeter-hide-users: False
    greeter-show-manual-login: True
    greeter-session: lightdm-gtk-greeter

