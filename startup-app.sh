#!/bin/bash
. .env
dotnet user-secrets init
dotnet user-secrets set ConnectionStrings:DefaultConnection "Server=db;Database=master;User=sa;Password=${DatabasePassword};" --project .
docker-compose up --build --remove-orphans