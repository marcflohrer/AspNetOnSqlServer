
#!/bin/bash
set -ex

>&2 echo "!!!11!!!!!!11!!!!!!11!!!!!!11!!!!!!11!!!"
>&2 echo "Running entrypoint.sh !!!11!!!!!!11!!!!!"
>&2 echo "!!!11!!!!!!11!!!!!!11!!!!!!11!!!!!!11!!!"

dotnet dev-certs https

until dotnet user-secrets init && dotnet user-secrets set ConnectionStrings:DefaultConnection "$1" --project .; do
>&2 echo "Setting up user secret: " $1
sleep 1
done

./my-demo-app

>&2 echo "!!!11!!!!!!11!!!!!!11!!!!!!11!!!!!!11!!!1!!!!!!11!!!!!"
>&2 echo "Running entrypoint.sh :: APP RUNNING !!!!!!!!!!11!!!!!"
>&2 echo "!!!11!!!!!!11!!!!!!11!!!!!!11!!!!!!11!!!1!!!!!!11!!!!!"
