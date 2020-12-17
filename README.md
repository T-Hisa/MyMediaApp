# README
* Ruby version
  ruby-version is 2.7.1

* Configuration
  Firstly, please execute the following command for access database.
    `cp .env.copy .env`

* Database creation
  Next, execute the following command.
    `docker-compose run web rails db:migrate`
  
* Database initialization
  ~ Next, execute the foolowing command to generate databases for developing. ~
    ~ `docker-compose run web rails db:seed` ~

* How to run the test suite
  Execute the following command.
    `docker-compose run web bundle exec rspec ./spec`

* Api
  For getting article list, visit following url.
    `http://aaaaa.monster/api/articles`
  And when you manipulating sql query, below params is valid.
    ・ For `SELECT {target} FROM article ORDER BY {order_target} {order_type}`
   1. `target` parameter -> for selecting column you want to get. Default value is `*`.
   2. `order_target` parameter -> for selecting column which sorts the obtaining params. Default value is `id`.
   3. `order_type` parameter -> for selecting column setting sort criteria. Default value is `desc`.
  
* Deployment instructions
  In this repository, using Capistrano and CircleCI.
  But, when deploying firstly, we must deploy from local by following command.
    `docker-compose run web bundle exec cap production deploy`
