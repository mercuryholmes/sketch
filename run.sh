#!/bin/bash

docker-compose up -d && \
docker-compose exec haskell stack run
