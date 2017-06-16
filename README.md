# perkbox-devops-test

### What is this test all about?

This test is all about setting up Terraform templates to deploy a set of infrastructure elements on AWS.
We would need an `EC2` instance behind an `ELB` (Elastic Load Balancer) on a custom `VPC` with a `Subnet`. Also we will need a `S3` bucket called `perkbox-devops-test` with a file uploaded to the bucket, named `helloworld`.

The `EC2` instance will be based on `Ubuntu 16.04`OS with `Nginx` as a webserver and `php-fpm` as a php-cgi processor behind the web server. The code of the website will be the code on this repository, `index.php`. So, when we type on the url of our browser the domain associated with the `ELB`, `index.php` should be called.

The code on `index.php` connects with a `S3` bucket and lists the objects on `perkbox-devops-test` `S3` bucket. You should see a `helloworld` message on the screen of our browser, if everything goes alright after the web page loads.

It's extremely recommendable to do the setup manually first, verify it works and then move into the automation part with Terraform.

Create a fork from the current repository and submit a Pull Request with Terraform templates and instructions to execute them once you're done.

### Instructions:

* Use this example as a starting point to create your Terraform templates:
https://github.com/hashicorp/terraform/tree/master/examples/aws-two-tier

* Use this nginx configuration, `/etc/nginx/sites-enabled/default`:
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
* Pull the code from the repository into `/var/www/html`

* Use composer to download php dependencies

* Don't modify `index.php` file

* Ask anything you need. Asking the correct questions is considered part of the test.

### References

* https://www.terraform.io/

* https://www.digitalocean.com/community/tutorials/how-to-install-linux-nginx-mysql-php-lemp-stack-in-ubuntu-16-04

* https://getcomposer.org/
