#!/bin/bash

#-- EDIT THE BELOW VALUES -----------------------
# The following values should already be established with CES:
# cloud_user="username"
# cloud_host="esaX.CUSTOMER.iphmx.com" or "smaX.CUSTOMER.iphmx.com"
## [ASSURE THAT YOU HAVE THE PROPER REGIONAL CES DATACENTER SET!]
# private_key="PATH_TO_SSH_PROVIDED_TO_CES_ATLAS"
# proxy_server="PROXY_SERVER" [SELECT ONLY ONE!]
#
## For 'proxy_server', these are SSH proxies:
## (2) US:
## f4-ssh.iphmx.com (68.232.128.202)
## f5-ssh.iphmx.com (68.232.134.202)
##
## (2) EU:
## f10-ssh.c3s2.iphmx.com (68.232.132.143)
## f11-ssh.c3s2.iphmx.com (68.232.138.143)
##
## (2) CA:
## f13-ssh.ca.iphmx.com (68.232.158.121)
## f14-ssh.ca.iphmx.com (216.71.128.121)
##
## (2) AWS:
## p3-ssh.r1.ces.cisco.com
## p4-ssh.r1.ces.cisco.com

cloud_user="username"
cloud_host="esaX.CUSTOMER.iphmx.com"
private_key="PATH_TO_SSH_PROVIDED_TO_CES_ATLAS"
proxy_server="PROXY_SERVER"

#-- LEAVE THESE VALUES AS-IS --------------------
# 'proxy_user' should not change
# 'remote_port' stays 22 (SSH)
# 'local_port' can be set to different value, if needed

proxy_user="dh-user"
remote_port=22
local_port=2222

#-- DO NOT EDIT BELOW THIS LINE -----------------

proxycmd="ssh -f -L $local_port:$cloud_host:$remote_port -i $private_key -N $proxy_user@$proxy_server"

printf "[-] Connecting to your proxy server ($proxy_server)...\n"
$proxycmd >/dev/null 2>&1
if nc -z 127.0.0.1 $local_port >/dev/null 2>&1; then
    printf "[-] Proxy connection successful.  Now connected to $proxy_server.\n"
else
    printf "[-] Proxy connection unsuccessful. Quitting...\n"
    exit
fi

# Find proxy ssh process
proxypid=`ps -xo pid,command | grep "$cloud_host" | grep "$proxy_server" | head -n1 | sed "s/^[ \t]*//" | cut -d " " -f1`
printf "[-] proxy running on PID: $proxypid\n"

printf "[-] Connecting to your CES appliance ($cloud_host)...\n\n"
ssh -p $local_port $cloud_user@127.0.0.1

printf "[-] Closing proxy connection...\n"
kill $proxypid

printf "[-] Done.\n"

#-- Want to avoid having to type password each time?
#-- See: https://www.cisco.com/c/en/us/support/docs/security/email-security-appliance/118305-technote-esa-00.html
#-- Need access to more than one ESA or SMA?  Copy the same script and rename to connect2ces_2.sh, or similar.
