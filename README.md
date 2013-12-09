heroku run rake db:seed -a easytowticket-prod
heroku run console -a easytowticket-prod
heroku run rake db:rollback -a easytowticket-prod
heroku run rake db:migrate -a easytowticket-prod


Read loag file
tail -F 50  ./log/test.log
tail -f log/development.log
heroku logs -t -a easytowticket-prod

Product.select("DISTINCT(PAGE)")

