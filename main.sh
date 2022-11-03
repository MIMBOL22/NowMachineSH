
if [ "$EUID" -ne 0 ] 
    then sudo bash ./main.sh
    exit
    else echo "Привет, устанавливаем веб сервер"
fi
add-apt-repository -y ppa:phpmyadmin/ppa
apt install -y mysql-server mysql-client nginx php7.4 php7.4-fpm php7.4-json php7.4-mysql php7.4-odbc phpmyadmin 
printf "server {\n        listen 80 default_server;\n        root /var/www/html;\n        index index.php index.html;\n        location / {\n                try_files $uri $uri/ =404;\n        }\n        location ~ \.php$ {\n                include snippets/fastcgi-php.conf;\n                fastcgi_pass unix:/var/run/php/php7.4-fpm.sock;\n        }\n}" >> /etc/nginx/sites-enabled/default
systemctl restart nginx
rm /var/www/html/index.html
printf "<?php \necho 'Hello, World\!';" >> /var/www/html/index.php
read -p "Имя пользователя для MySQL суперпользователя: " mysql_user
read -s -p "Пароль для MySQL суперпользователя: " mysql_pass
echo "\n"
read -p "IP доступа для MySQL суперпользователя: [localhost]" mysql_host
mysql -e "CREATE USER '${mysql_user}'@'${mysql_host:-localhost}' IDENTIFIED WITH mysql_native_password BY '${mysql_pass}';"
echo "Готово ;)"
