# README
# Ruby version
  ruby-version is 2.7.1

# Configuration
  Firstly, please execute the following command for access database.
  
  `cp .env.copy .env`

# Database creation
  Next, execute the following command.
   
  `docker-compose run web rails db:migrate`
  
# Database initialization
  ~Next, execute the foolowing command to generate databases for developing.~
  
  ~`docker-compose run web rails db:seed`~
  
# How to start developing
  By executing the following command, the server for developing starts.
    
    `docker-compose up`

# How to run the test suite
  Execute the following command.
  
  `docker-compose run web bundle exec rspec ./spec`

# Api
There are two ways to acquire articles type of json.

  1. For getting article list, visit following url.
  
      `http://aaaaa.monster/api/articles`
  
  And when you manipulating sql query, below params is valid for sql query.
  ・ The Sql Query is
  
      `SELECT {target} FROM article ORDER BY {order_target} {order_type}`
  
  The query parameters are as below.
   1. `target` parameter -> for selecting column you want to get. Default value is `*`.
   2. `order_target` parameter -> for selecting column which selects sort target of the obtaining params. Default value is `id`.
   3. `order_type` parameter -> for selecting column setting sort criteria. Default value is `desc`.
   
  When using query, enter http request as below.
  
        `http://aaaaa.monster/api/articles?target=title&order_target=created_at`
        
  2. For getting special article(knowing the `id`), visit following url.
  
      `http://aaaaa.monster/api/article/#{id}`
   
  
# Deployment instructions
  In this repository, using Capistrano and CircleCI.
  But, when deploying firstly, we must deploy from local by following command.
    `docker-compose run web bundle exec cap production deploy`
