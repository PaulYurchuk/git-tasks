#!/bin/bash
sudo su
yum install nginx -y;
sed -i '38d;39d;40d;41d;42d;43d;44d;45d;46d;47d;48d;49d;50d;51d;52d;53d;54d;55d;56d;57d' /etc/nginx/nginx.conf;

touch /etc/nginx/conf.d/newser.conf;
echo "server {
        listen       80 default_server;
        listen       [::]:80 default_server;
        server_name  _;
        root         /usr/share/nginx/html;

        # Load configuration files for the default server block.
        include /etc/nginx/default.d/*.conf;

        location / {
	proxy_pass http://127.0.0.1:8080;

        }

        error_page 404 /404.html;
            location = /40x.html {
        }

        error_page 500 502 503 504 /50x.html;
            location = /50x.html {
        }
    } " >>/etc/nginx/conf.d/newser.conf;


systemctl enable nginx;
systemctl start nginx;

echo "127.0.0.1 jenkins" >> /etc/hosts
<<<<<<< HEAD
echo "Hello"

=======
echo "1111111111111111111111111111111111"
>>>>>>> nginx
