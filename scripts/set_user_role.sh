#!/bin/bash

docker run -dit --network host --name=pgclient codingpuss/postgres-client
docker exec -it pgclient psql postgresql://postgres:test@localhost:5432/postgres -c "UPDATE users SET role = '$2' WHERE id = '$1'"
docker stop pgclient
docker rm pgclient