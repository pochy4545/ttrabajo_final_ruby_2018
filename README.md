# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

requisitos:

* Ruby version(ruby 2.5.1)/bundler
* Rails 5.2.1.1
* mysql  Ver 14.14 (sudo apt-get install mysql-client libmysqlclient-dev)

* Database creation:* mysql -h nombre_servidor -u nombre_usuario -p
                    * create database trabajo_final;
                    * grant all privileges on library_development.* to 'root'@'localhost' identified by 'password';
                    * FLUSH PRIVILEGES;

* Database initialization: *modificar el archivo config/database.yml
                           *Debajo de la defaultsección, busque la línea que dice "contraseña:" y agregue la contraseña
                           al final de la misma. Debe tener un aspecto similar al siguiente (reemplace la parte resaltada
                           con su contraseña de root de MySQL): 
                                          password: mysql_root_password
                           guardar y salir
                           *ejecutar rails db:create 


* How to run the test suite

