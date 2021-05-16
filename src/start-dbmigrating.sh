. .env
cd Data/Generated/ && find . ! -name . -prune ! -name ../Models -exec rm {} \; && cd ../..
dotnet build
dotnet user-secrets set ConnectionStrings:DefaultConnection "${DatabaseConnectionString};" --project .
docker-compose -f docker-compose-dbmigrate.yml up --build --remove-orphans 
dotnet user-secrets clear
