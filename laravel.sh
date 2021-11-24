#!/bin/bash
echo "*** Begin install Laravel ***"

#Install PHP
sudo apt update && sudo apt upgrade
sudo apt-get install -y phpunit zip unzip php-zip php7.2-fpm php7.2-mysql php7.2-mbstring php7.2-xml php7.2-bcmath

#Install Composer
sudo apt install -y composer
composer --version

#Install Laravel
composer create-project --prefer-dist laravel/laravel ~/php-projects/Laravel/my_app

#Set folder owners
sudo chown -R www-data:www-data /var/www/my_app/storage
sudo chown -R www-data:www-data /var/www/my_app/bootstrap/cache

#Install nginx and mysql
sudo apt install -y nginx
sudo ln -s /etc/nginx/sites-available/my_app /etc/nginx/sites-enabled/
#ansible config file for php7.2
sudo systemctl reload nginx

#Install mysql
sudo apt install -y mysql-server
sudo apt install -y php-fpm php-mysql
#ansible database seed and migration
#mysql -u root -p

#wsl2 commands to start nginx and php7.2-fpm
sudo service php7.2-fpm start
sudo service nginx start

#Start server
cd ~/php-projects/Laravel/my_app
php artisan serve

#setup github
cd /var/www/my_app
sudo git init
sudo git config user.name "cgennari76"
sudo git remote add origin https://github.com/cgennari76/my_app.git
git pull origin main

#seed database
mysql -u root <<-EOF
INSERT INTO travel_list.places (name, visited)
VALUES ("Amsterdam", false),
("Poznan", true);
EOF

python3 -m venv .venv.
source .venv/bin/activate
pip install wheel
pip install Rust
pip install setuptools-rust 
python -m pip install ansible
