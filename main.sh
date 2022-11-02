echo "Привет, устанавливаем веб сервера, просьба вводить пароли для root доступа"
sudo add-apt-repository -y ppa:phpmyadmin/ppa
sudo apt install -y tasksel nginx php7.4 php7.4-fpm php7.4-json php7.4-mysql php7.4-odbc phpmyadmin 
sudo tasksel install lamp
sudo apt remove -y apache2
sudo apt remove
