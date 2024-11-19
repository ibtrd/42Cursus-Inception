CREATE DATABASE IF NOT EXISTS `wordpress`;
CREATE USER IF NOT EXISTS 'wordpress_user'@'%' IDENTIFIED BY 'wordpress_password';
GRANT ALL PRIVILEGES ON `wordpress`.* TO 'wordpress_user'@'%';
CREATE USER IF NOT EXISTS 'wordpress_readonly'@'%' IDENTIFIED BY 'readonly_password';
GRANT SELECT ON `wordpress`.* TO 'wordpress_readonly'@'%';
FLUSH PRIVILEGES;
