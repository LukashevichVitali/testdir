#!/bin/bash

yum install httpd -y
cp /vagrant/workers.properties /etc/httpd/conf/workers.properties
cp /vagrant/mod_jk.conf  /etc/httpd/conf.d/mod_jk.conf
cp /vagrant/mod_jk.so /etc/httpd/modules/
systemctl enable httpd
systemctl start httpd