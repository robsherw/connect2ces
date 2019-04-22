# connect2ces
For Cisco Cloud Email Security (CES) customers...  
A shell script utilizing SSH to make command line interface (CLI) access via CES proxy simple

## Pre-requisites
As a CES customer, you should have engaged CES On-Boarding/Ops, or Cisco TAC to have SSH Keys exchanged and placed.

1) Generate Private/Public RSA key(s)
2) Provide Cisco your **Public** RSA key
3) Wait for Cisco to save and notify you that your key(s) have been saved to your CES customer account
4) Copy and modify the connect2ces.sh script

## How do I create Private/Public RSA keys(s)?
Cisco recommends using for Unix/Linux/OS X:

'ssh-keygen -b 2048 -t rsa -f ~/.ssh/<NAME>'

For more information: https://www.ssh.com/ssh/keygen/

Cisco recommends using for Windows:

For more information: https://www.ssh.com/ssh/putty/windows/puttygen

**Please make sure that you safeguard access to your RSA private keys at all times.**  
**Please do not send your private key to Cisco, only the public key (.pub)**  
**When submitting your public key to Cisco, please identify the email address/first name/last name that they key is for.**

## How do I open a Cisco Support Request to provide my public key?

https://mycase.cloudapps.cisco.com/case

## How can I configure my Email Security Appliance (ESA) to log-in without prompting for password?

https://www.cisco.com/c/en/us/support/docs/security/email-security-appliance/118305-technote-esa-00.html

## What should this look like once I have the pre-requisites completed?

robsherw@my_local > ~ ./ces_connect
[-] Connecting to your proxy server (f4-ssh.iphmx.com)...
[-] Proxy connection successful.  Now connected to f4-ssh.iphmx.com.
[-] proxy running on PID: 31253
[-] Connecting to your CES appliance (esa1.rs1234-01.iphmx.com)...


Last login: Mon Apr 22 11:33:45 2019 from 10.123.123.123
AsyncOS 12.1.0 for Cisco C100V build 071

Welcome to the Cisco C100V Email Security Virtual Appliance

NOTE: This session will expire if left idle for 1440 minutes. Any uncommitted configuration changes will be lost. Commit the configuration changes as soon as they are made.

(Machine esa1.rs1234-01.iphmx.com)>
