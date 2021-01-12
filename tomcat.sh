#!/bin/bash

yum install java-1.8.0-openjdk tomcat -y
cp /vagrant/clusterjsp.war /usr/share/tomcat/webapps/
systemctl enable tomcat
systemctl start tomcat