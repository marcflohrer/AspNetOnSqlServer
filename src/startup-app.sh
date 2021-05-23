#!/bin/bash
. .env

mkdir -p mssql/data

dotnet build &
dotnet user-secrets init 
dotnet user-secrets set ConnectionStrings:DefaultConnection "${DatabaseConnectionString}" --project .
docker-compose up --build --remove-orphans -d
dotnet user-secrets clear
#docker system prune -f
