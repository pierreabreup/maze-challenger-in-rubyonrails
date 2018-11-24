SHELL := /bin/bash # Use bash syntax

run:
	docker-compose run --service-ports --rm app

dev:
	docker exec -it clark_app_run_1 bash

railsc:
	docker exec -it clark_app_run_1 rails c

destroy:
	docker-compose down
	docker volume rm maze-challenger-in-rubyonrails_rails-usrlocal
	docker rmi maze-challenger-in-rubyonrails_app
	rm -f db/development.sqlite3
	rm -f db/test.sqlite3
