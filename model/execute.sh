#!/bin/bash
SQL_FILE="cats.sql"

docker cp "./${SQL_FILE}" "postgres:/tmp/${SQL_FILE}"
docker exec postgres psql -Upostgres sketch -f "/tmp/${SQL_FILE}"
