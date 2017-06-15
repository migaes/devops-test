# perkbox-devops-test

### What this test is all about?

This test is about setting up Terraform template and deploy the elements described on it to AWS.
We would need an EC2 instance behind an ELB (Elastic Load Balancer) on a custom VPC with a Subnet on it. Also we would need a S3 bucket called `perkbox-devops-test` with a file uploaded on it, named `helloworld`.

The EC2 instance will be based on `Ubuntu 16.04`OS with `Nginx` as a webserver and `php-fpm` as a php-cgi processor behind the web server. The code of the website will be the code on this repository (index.php),so when we type on our browser url the domain associated to the ELB this code should be executed. The code on `index.php` connects to a `S3 Bucket` and lists the objects on `perkbox-devops-test S3 bucket`, so you should see a helloworld string on your browser if everything goes alright.

It's extremely recommendable to do the setup manually first, verify it works and then move into the automation with Terraform.

Create a fork of the repository and submit a Pull Request with Terraform templates and instructions to execute them.

### Instructions:

* Use this example to create Terraform template:
https://github.com/hashicorp/terraform/tree/master/examples/aws-two-tier

* Use this nginx configuration:
```
server {
        listen 80 default_server;
        listen [::]:80 default_server;

        index index.php
        server_name localhost;
        root /var/www/html;

        location / {
                try_files $uri $uri/ =404;
        }

        location ~ \.php$ {
                include snippets/fastcgi-php.conf;
                fastcgi_pass 127.0.0.1:9000;
        }

        location ~ /\.ht {
                deny all;
        }
}
```

* Use composer to download php dependencies

* Don't modify index.php code

* Ask anything you need to mikel@perkbox.co.uk. Asking the correct questions can be considered as part of the test.

### References

* https://www.terraform.io/

* https://www.digitalocean.com/community/tutorials/how-to-install-linux-nginx-mysql-php-lemp-stack-in-ubuntu-16-04

* https://getcomposer.org/
