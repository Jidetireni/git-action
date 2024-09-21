.PHONY: build network run volume ps images rm stop up down

build:
	docker build -t mern-frontend ./frontend
	docker build -t mern-backend ./backend

network:
	docker network create mern

volume:
	docker volume create mongodb-data

run:
	docker run -d -p 5173:5173 --name frontend --network mern mern-frontend
	docker run -d -p 27017:27017 --name mongodb --network mern -v mongodb-data:/data/db mongo:latest
	docker run -d -p 5050:5050 --name backend --network mern mern-backend

ps:
	docker ps

images:
	docker images

rm:
	docker rm -f frontend backend mongodb

stop:
	docker stop frontend backend mongodb

up:
	docker-compose up -d

down:
	docker-compose down
