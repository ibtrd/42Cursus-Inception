CREATE DATABASE IF NOT EXISTS wordpress;
CREATE USER 'wordpress_user'@'%' IDENTIFIED BY 'secure_password';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress_user'@'%';
FLUSH PRIVILEGES;