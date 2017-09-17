#!/bin/bash -x

sudo apt-get update -y
sudo apt-get install -y nginx php-fpm git php7.0-xml # required for aws new sdk


## Configure nginx, double dollar signs to escape terraform interpolation
echo "
server {
    listen 80 default_server;
    listen [::]:80 default_server;

    root /var/www/html/application/applicationcode;
    index index.php;

    server_name server_domain_or_IP;

    location / {
        try_files $$uri $$uri/ =404;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/run/php/php7.0-fpm.sock;
    }

    location ~ /\.ht {
        deny all;
    }
}" > /etc/nginx/sites-enabled/default

sudo nginx -t
sudo systemctl reload nginx

## Configure applicationcode to point to specified s3 bucket
sudo git clone https://github.com/arehmandev/devops-test /var/www/html/application


sudo sed -i 's/perkbox-devops-test/${s3bucketid}/g' index.php

# Get composer
sudo /usr/bin/php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
sudo /usr/bin/php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
sudo /usr/bin/php composer-setup.php  --install-dir=/bin
sudo /usr/bin/php -r "unlink('composer-setup.php');"

sudo /bin/composer.phar install -d /var/www/html/application/applicationcode