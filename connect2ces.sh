#!/bin/bash

#-- EDIT THE BELOW VALUES -----------------------
# The following values should already be established with CES:
# cloud_user="username"
# cloud_host="esaX.CUSTOMER.iphmx.com" or "smaX.CUSTOMER.iphmx.com"
## [ASSURE THAT YOU HAVE THE PROPER REGIONAL CES DATACENTER SET!]
# private_key="LOCAL_PATH_TO_SSH_PRIVATE_RSA_KEY"
# proxy_server="PROXY_SERVER" [SELECT ONLY ONE!]
#
## For 'proxy_server', these are SSH proxies:
## 
## AP (ap.iphmx.com)
## f15-ssh.ap.iphmx.com
## f16-ssh.ap.iphmx.com
## 
## AWS (r1.ces.cisco.com)
## p3-ssh.r1.ces.cisco.com
## p4-ssh.r1.ces.cisco.com
## 
## CA (ca.iphmx.com)
## f13-ssh.ca.iphmx.com
## f14-ssh.ca.iphmx.com
## 
## EU (c3s2.iphmx.com)
## f10-ssh.c3s2.iphmx.com
## f11-ssh.c3s2.iphmx.com
## 
## EU (eu.iphmx.com)(German DC)
## f17-ssh.eu.iphmx.com
## f18-ssh.eu.iphmx.com
## 
## US (iphmx.com)
## f4-ssh.iphmx.com
## f5-ssh.iphmx.com

cloud_user="username"
cloud_host="esaX.CUSTOMER.iphmx.com"
private_key="LOCAL_PATH_TO_SSH_PRIVATE_RSA_KEY"
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
