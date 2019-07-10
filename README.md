# Zabbix SSL Certificate template
This is template and howto for SSL expiration check and grading SSL certificate deployment.

**Monitoring:**
1)Certificate issuer
2)Certificate expiration
3)Certificate installation grade with [SSL Labs](https://www.ssllabs.com/) API.

**Latest data**
![alt SSL latest data](https://github.com/hermanekt/Zabbix-ssl-certificate-check-with-grade/raw/master/IMG/latest_data.jpg)

**Items**
![alt SSL items](https://github.com/hermanekt/Zabbix-ssl-certificate-check-with-grade/raw/master/IMG/items.jpg)

**Triggers**
![alt SSL triggers](https://github.com/hermanekt/Zabbix-ssl-certificate-check-with-grade/raw/master/IMG/triggers.jpg)

**Macros**
![alt SSL macros](https://github.com/hermanekt/Zabbix-ssl-certificate-check-with-grade/raw/master/IMG/macros.jpg)

## Install instruction ##

All operations is needed to do at zabbix or proxy servers.

**CentOS,RHEL**
```console
yum install zabbix-sender
```
**Debian, Ubuntu**
```console
apt-get install zabbix-sender
```

**Clone repository**
```console
cd /tmp
git clone git@github.com:hermanekt/Zabbix-ssl-certificate-check-with-grade.git
```

**Copy scripts**
```console
cp /tmp/Zabbix-ssl-certificate-check-with-grade/ssllabs_checker.sh /usr/lib/zabbix/externalscripts
cp /tmp/Zabbix-ssl-certificate-check-with-grade/ssllabs_checker_at.sh /usr/lib/zabbix/externalscripts
cp /tmp/Zabbix-ssl-certificate-check-with-grade/zext_ssl_expiry.sh /usr/lib/zabbix/externalscripts
cp /tmp/Zabbix-ssl-certificate-check-with-grade/zext_ssl_issuer.sh /usr/lib/zabbix/externalscripts
```

**Enable executing**
```console
chmod +x zext_ssl_*
chmod +x ssllabs_checker*
```


## Install GO or copy my compiled package ssllabs-scan (version v1.35.1) ##
**1) Copy**
```console
cp /tmp/Zabbix-ssl-certificate-check-with-grade/ssllabs-scan /usr/lib/zabbix/externalscripts
chmod +x /usr/lib/zabbix/externalscripts/ssllabs-scan
```
## OR ##

**1) Install golang**
**CentOS,RHEL**
```console
yum install golang
```
**Debian, Ubuntu**
```console
apt-get install golang
```
**2) Compile sslabs-scan package**
```console
cd /tmp
git clone https://github.com/ssllabs/ssllabs-scan/
cd ssllabs-scan/
go build
mv /tmp/ssllabs-scan/ssllabs-scan /usr/lib/zabbix/externalscripts/
cd && rm -rf /tmp/ssllabs-scan/
```

**Clean server**
```console
rm -rf /tmp/Zabbix-ssl-certificate-check-with-grade
```
## Import template in zabbix frontend ##
File: [Template_SSL_Certificates.xml](https://github.com/hermanekt/Zabbix-ssl-certificate-check-with-grade/raw/master/Template_SSL_Certificates.xml)

## Create dummy host and set template ##
Dummy host with hostname is URL name for example https://www.google.com/ hostname is: www.google.com

**Host connection:**
![alt SSL Host Connection](https://github.com/hermanekt/Zabbix-ssl-certificate-check-with-grade/raw/master/IMG/host_conn.jpg)

**Host template:**
![alt SSL Host template](https://github.com/hermanekt/Zabbix-ssl-certificate-check-with-grade/raw/master/IMG/host_template.jpg)
