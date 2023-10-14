#!/usr/bin/env bash

wget https://apt.puppet.com/puppet-release-bullseye.deb
sudo dpkg -i puppet-release-bullseye.deb
sudo apt-get update
sudo apt-get install puppet-agent -y
# prep the config then procede to run the agent
sudo nano /etc/puppetlabs/puppet/puppet.conf
# add the following to the puppet.conf file
```
[main]
vardir = /var/lib/puppet
logdir = /var/log/puppet
rundir = /var/run/puppet
ssldir = $vardir/ssl

[agent]
# pluginsync is deprecated
pluginsync      = true 
report          = true
ca_server       = pup01.hys.ssy.dk
certname        = HOSTNAME.hys.ssy.dk
server          = pup01.hys.ssy.dk
environment     = production
runinterval     = 15m
```
sudo ln -s /opt/puppetlabs/bin/puppet /usr/bin/puppet
sudo /opt/puppetlabs/bin/puppet resource service puppet ensure=running enable=true
sudo puppet agent --test --waitforcert 30
# go to foreman and sign the cert
# then run this on the agent
sudo ln -s /opt/puppetlabs/bin/puppet /usr/bin/puppet
sudo mkdir /etc/puppet
sudo ln -s /etc/puppetlabs/puppet/puppet.conf /etc/puppet/puppet.conf
# generate register link from foreman, use the insecure link while testing
# Run the register command on the agent
curl -sS --insecure 'https://pup01.hys.ssy.dk/register?location_id=2&operatingsystem_id=2&organization_id=1&update_packages=false' -H 'Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo0LCJpYXQiOjE2OTczMDMxNzAsImp0aSI6ImJlZDBiYzE1NjM1MGMwNDQ1YjhjMzE5ODQ5Mjk2ZjgxYTI0ODMxMGNmN2NmZTFhMjJhODRlNzFkOWIzNjVmODUiLCJleHAiOjE2OTczMTc1NzAsInNjb3BlIjoicmVnaXN0cmF0aW9uI2dsb2JhbCByZWdpc3RyYXRpb24jaG9zdCJ9.Vxz7Hatbi562EtoLF5iInRo1XfPdLZSx2wsc3Jk7FII' | sudo bash