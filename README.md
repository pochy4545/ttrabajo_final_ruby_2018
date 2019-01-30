# README

Es una aplicación desarrollada con Ruby on Rails como trabajo integrador de la materia Taller de Tecnologías de producción de Software de la Universidad Nacional de La Plata.

## Pre_requisitos 📋

  * Ruby version(ruby 2.5.1) y bundler
  * Rails 5.2.1.1
  * mysql (sudo apt-get install mysql-client libmysqlclient-dev)
  * git
  
## Comenzando 🚀
   ```
   git clone git@github.com:pochy4545/ttrabajo_final_ruby_2018  o descarcar directamente en zip
   ```
  ## Configuracion 🔧:
  ```
  * bundler install (dentro de la carpeta principal)
  ```
  ```
  * Database creation:* mysql -h nombre_servidor -u nombre_usuario -p
                      * create database trabajo_final;
                      * grant all privileges on trabajo_final.* to 'youruser'@'yourhost' identified by 'yourpassword';
                      * FLUSH PRIVILEGES;
  ```
  ```
  * Database initialization: *modificar el archivo config/database.yml
                             *Debajo de la defaultsección, busque la línea que dice "contraseña:" y agregue la contraseña
                             al final de la misma. Debe tener un aspecto similar al siguiente:
                                            password: mysql_root_password
                             guardar y salir
                             *ejecutar rails db:create 
   ```
  ```
   rails db:seed (para cargar los datos pre-creados )
  ```
### Correr aplicacion  ⌨️:
  ```
   rails server  o rails s  (sobre la carpeta principal)
  ```
   ### !listo! 📦
  ```
   visulaizar en http://localhost:3000
  ```
## Ejecutar todos los test ⚙️
   ```
   * correr todos los test: bundle exec rspec spec/model (sobre la carpeta principal)
   ```
   
## app corriendo en heroku
   ```
   https://intense-scrubland-21273.herokuapp.com
