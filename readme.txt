If you have docker and docker compose you can run this via:

  docker-compose build
  docker-compose up

Then visit http://localhost:8080/ (if you need to map to a different port, see the docker-compose.yml file)

Direct access to the mysql command line:

  docker-compose exec db mysql --password=test123 icecream

Database and tables are created and populated automagically via docker/mysql/initialize.sql during the build/up proces.