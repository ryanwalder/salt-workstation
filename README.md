# salt-workstation

Salt states for managing my workstations.

# Formula

This repo can be used as a normal [formula](https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html) in the usual way on a master.

It can also be used in a local/masterless fashion with the included bootstrap to install salt, load needed upstream repos via gitfs, then run a highstate.
