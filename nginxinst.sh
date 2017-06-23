#!/bin/bash
yum -y install nginx
sed -i  's/ location \/ {/ location \/ {proxy_pass http:\/\/192.168.56.99:8080;/' /etc/nginx/nginx.conf;
systemctl start nginx;
systemctl enable nginx; 
