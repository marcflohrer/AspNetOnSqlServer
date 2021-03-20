
#!/bin/bash

set -e

run_cmd="dotnet app.dll"

until PATH="$PATH:/root/.dotnet/tools"; do
>&2 echo "Setting up env variables..."
sleep 1
done

until dotnet tool install --global dotnet-ef; do
>&2 echo "EntityFramework is installing..."
sleep 1
done

until dotnet user-secrets init && dotnet user-secrets set ConnectionStrings:AspNetCoreOnSqlServerConnectionString "Server=db;Database=master;User=sa;Password=$1;" --project .; do
>&2 echo "Setting up user secret: " $1
sleep 1
done

>&2 echo "!!!11!!!!!!11!!!!!!11!!!!!!11!!!!!!11!!!1!!!!!!11!!!!!"
>&2 echo "Running entrypoint.sh :: 1 SECRETS SET UP  !!!!!!!11!!!!!"
>&2 echo "!!!11!!!!!!11!!!!!!11!!!!!!11!!!!!!11!!!1!!!!!!11!!!!!"

>&2 echo "Building the project ..."
until dotnet build; do
>&2 echo "The project build is running..."
sleep 1
done

>&2 echo "!!!11!!!!!!11!!!!!!11!!!!!!11!!!!!!11!!!1!!!!!!11!!!!!"
>&2 echo "Running entrypoint.sh :: 1 BUILD DONE !!!!!!!!!!!!!!11"
>&2 echo "!!!11!!!!!!11!!!!!!11!!!!!!11!!!!!!11!!!1!!!!!!11!!!!!"

until dotnet ef database update; do
>&2 echo "SQL Server is starting up"
sleep 1
done

>&2 echo "SQL Server is up - starting scaffolding ..."
until dotnet ef dbcontext scaffold Name=ConnectionStrings:AspNetCoreOnSqlServerConnectionString Microsoft.EntityFrameworkCore.SqlServer -o DbModels -f; do
>&2 echo "Scaffolding the database..."
sleep 1
done