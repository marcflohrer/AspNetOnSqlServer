. .env
# dotnet user-secrets init
# dotnet user-secrets set ConnectionStrings:AspNetCoreOnSqlServerConnectionString "Server=db;Database=master;User=sa;Password=${DatabasePassword};" --project .
cd Data/Generated/ && find . ! -name . -prune ! -name ../Models -exec rm {} \; && cd ../..
docker-compose -f docker-compose-dbscaffold.yml up --build --remove-orphans 
cd Data/Generated/ && find . ! -name . -prune ! -name ../../Models/ -exec mv {} ../../Models/ \; && cd ../..