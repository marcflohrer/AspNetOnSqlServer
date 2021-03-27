. .env
cd Data/Generated/ && find . ! -name . -prune ! -name ../Models -exec rm {} \; && cd ../..
docker-compose -f docker-compose-dbscaffold.yml up --build --remove-orphans 
# cd Data/Generated/ && find . ! -name . -prune ! -name ../../Models/ -exec mv {} ../../Models/ \; && cd ../..