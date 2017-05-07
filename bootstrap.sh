#!/usr/bin/env bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

read -r -d '' salt_config <<"EOF"
file_client: local

gitfs_provider: gitpython

fileserver_backend:
  - roots
  - git

gitfs_remotes:
  - https://github.com/ryanwalder/salt-workstation.git
  - https://github.com/ryanwalder/lightdm-formula.git
  - https://github.com/ryanwalder/i3wm-formula.git

file_roots:
  base:
    - /srv/salt

pillar_roots:
  base:
    - /srv/pillar
EOF

read -r -d '' pillar <<"EOF"
workstation:
  username: ryan
  home: /home/ryan
  fullname: Ryan Walder
  email: ryan.walder@gmail.com
EOF

apt-get install -y curl git-core python-git

mkdir -p /srv/salt /srv/pillar

curl -L https://bootstrap.saltstack.com | sh

ln -s $(pwd)/workstation /srv/salt/workstation
cp $(pwd)/top.sls /srv/salt/top.sls
cp $(pwd)/top.sls /srv/pillar/top.sls
echo "$pillar" > /srv/pillar/workstation.sls
echo "$salt_config" > /etc/salt/minion

systemctl restart salt-minion

salt-call state.highstate --log-level info --local
