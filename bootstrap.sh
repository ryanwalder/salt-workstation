#!/usr/bin/env bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

read -r -d '' salt_config <<"EOF"
file_client: local

fileserver_backend:
  - roots

file_roots:
  base:
    - /srv/salt

pillar_roots:
  base:
    - /srv/pillar
EOF

apt-get install -y curl

mkdir -p /srv/salt /srv/pillar

#curl -L https://bootstrap.saltstack.com | sh

cp -r $(pwd)/workstation /srv/salt
cp $(pwd)/top.sls /srv/salt/top.sls
cp $(pwd)/top.sls /srv/pillar/top.sls
cp $(pwd)/pillar.sls /srv/pillar/workstation.sls
echo "$salt_config" > /etc/salt/minion

#systemctl restart salt-minion

salt-call state.highstate --log-level debug --local
