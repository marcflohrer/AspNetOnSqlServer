#!/bin/bash
. .env
dotnet user-secrets init
dotnet user-secrets set ConnectionStrings:DefaultConnection "Server=db;Database=master;User=sa;Password=${DatabasePassword};" --project .
dotnet user-secrets set ConnectionString "Server=db;Database=master;User=sa;Password=${DatabasePassword};" --project .
dotnet user-secrets set DatabasePassword "${DatabasePassword}" --project .
docker-compose up --build --remove-orphans