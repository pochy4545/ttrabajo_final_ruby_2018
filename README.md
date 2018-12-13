# README

*requisitos:

  * Ruby version(ruby 2.5.1)/bundler gem
  * Rails 5.2.1.1
  * mysql  Ver 14.14 (sudo apt-get install mysql-client libmysqlclient-dev)
  * git
  
*configurcion:
  git clone git@github.com:pochy4545/ttrabajo_final_ruby_2018  o descarcar directamente en zip
  
  * Database creation:* mysql -h nombre_servidor -u nombre_usuario -p
                      * create database trabajo_final;
                      * grant all privileges on trabajo_final.* to 'user'@'host' identified by 'password';
                      * FLUSH PRIVILEGES;

  * Database initialization: *modificar el archivo config/database.yml
                             *Debajo de la defaultsección, busque la línea que dice "contraseña:" y agregue la contraseña
                             al final de la misma. Debe tener un aspecto similar al siguiente:
                                            password: mysql_root_password
                             guardar y salir
                             *ejecutar rails db:create 
   *bundler install

*correr test:
   * correr todos los test: bundle exec rspec spec/model
