# Zabbix SSL Certificate template (grading included)
This a guide on howto deploy and configure this template for SSL expiration check and grading SSL certificate deployment.

**Monitoring:**
1) Running HTTPS service (port)
2) Certificate issuer
3) Certificate expiration
4) Certificate installation grade with [SSL Labs](https://www.ssllabs.com/) API.

**Latest data**
![alt SSL latest data](https://github.com/hermanekt/Zabbix-ssl-certificate-check-with-grade/raw/master/IMG/latest_data.jpg)

**Items**
![alt SSL items](https://github.com/hermanekt/Zabbix-ssl-certificate-check-with-grade/raw/master/IMG/items.jpg)

**Triggers**
![alt SSL triggers](https://github.com/hermanekt/Zabbix-ssl-certificate-check-with-grade/raw/master/IMG/triggers.jpg)

**Macros**
![alt SSL macros](https://github.com/hermanekt/Zabbix-ssl-certificate-check-with-grade/raw/master/IMG/macros.jpg)

## Install instruction ##

The following steps need to be performed on all zabbix servers (or proxy servers respectively).

**CentOS, RHEL**
```console
yum install zabbix-sender
```
**Debian, Ubuntu**
```console
apt-get install zabbix-sender
```

**Clone the repository**
```console
cd /tmp
git clone git@github.com:hermanekt/Zabbix-ssl-certificate-check-with-grade.git
```

**Copy scripts to their respective locations**
```console
cp /tmp/Zabbix-ssl-certificate-check-with-grade/ssllabs_checker.sh /usr/lib/zabbix/externalscripts
cp /tmp/Zabbix-ssl-certificate-check-with-grade/ssllabs_checker_at.sh /usr/lib/zabbix/externalscripts
cp /tmp/Zabbix-ssl-certificate-check-with-grade/zext_ssl_expiry.sh /usr/lib/zabbix/externalscripts
cp /tmp/Zabbix-ssl-certificate-check-with-grade/zext_ssl_issuer.sh /usr/lib/zabbix/externalscripts
```

**Set an execution bit**
```console
chmod +x zext_ssl_*
chmod +x ssllabs_checker*
```

## Install GO or copy over the pre-compiled package 'ssllabs-scan' (version v1.35.1) ##
**Here you have 2 options - either to use the precompiled package I've provided, or you can build your own package from scratch.**

**1) Copy the package**
```console
cp /tmp/Zabbix-ssl-certificate-check-with-grade/ssllabs-scan /usr/lib/zabbix/externalscripts
chmod +x /usr/lib/zabbix/externalscripts/ssllabs-scan
```
## OR ##

**1) Install GOlang**

**CentOS, RHEL**
```console
yum install golang
```
**Debian, Ubuntu**
```console
apt-get install golang
```
**2) Build sslabs-scan package**
```console
cd /tmp
git clone https://github.com/ssllabs/ssllabs-scan/
cd ssllabs-scan/
go build
mv /tmp/ssllabs-scan/ssllabs-scan /usr/lib/zabbix/externalscripts/
cd && rm -rf /tmp/ssllabs-scan/
```

## Clean up the server ##
```console
rm -rf /tmp/Zabbix-ssl-certificate-check-with-grade
```
## Import the template to zabbix frontend ##
File: [Template_SSL_Certificates.xml](https://github.com/hermanekt/Zabbix-ssl-certificate-check-with-grade/raw/master/Template_SSL_Certificates.xml)

## Create dummy host and link the template to it ##
Jako hostname je pouzita url adressa bez https 
Dummy host with hostname is URL name for example https://www.google.com/ hostname is: www.google.com

**Host connection:**
![alt SSL Host Connection](https://github.com/hermanekt/Zabbix-ssl-certificate-check-with-grade/raw/master/IMG/host_conn.jpg)

**Host template:**
![alt SSL Host template](https://github.com/hermanekt/Zabbix-ssl-certificate-check-with-grade/raw/master/IMG/host_template.jpg)

[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=GEH7YJEBWTFWE&currency_code=USD&source=url)
