
#!/bin/bash
set -ex

>&2 echo "!!!11!!!!!!11!!!!!!11!!!!!!11!!!!!!11!!!"
>&2 echo "Running entrypoint.sh !!!11!!!!!!11!!!!!"
>&2 echo "!!!11!!!!!!11!!!!!!11!!!!!!11!!!!!!11!!!"

apt-get update && apt-get install wget -y

until wget https://packages.microsoft.com/config/debian/10/packages-microsoft-prod.deb -O packages-microsoft-prod.deb; do 
>&2 echo "downloading packages-microsoft-prod..."
sleep 1
done

apt-get remove wget -y

dpkg -i packages-microsoft-prod.deb
apt-get update; \
  apt-get install -y apt-transport-https && \
  apt-get update && \
  apt-get install -y dotnet-sdk-5.0

until dotnet dev-certs https; do
>&2 echo "Setting up developer certificate..."
sleep 1
done

until dotnet user-secrets init && dotnet user-secrets set ConnectionStrings:DefaultConnection "$1" --project .; do
>&2 echo "Setting up user secret: " $1
sleep 1
done

apt-get update; \
  apt-get install -y apt-transport-https && \
  apt-get update && \
  apt-get remove -y dotnet-sdk-5.0 && \
  apt-get remove -y aspnetcore-targeting-pack-5.0 && \
  apt-get remove -y dotnet-apphost-pack-5.0 && \
  apt-get clean

until dotnet app.dll; do
>&2 echo "Starting up the app..."
sleep 1
done

>&2 echo "!!!11!!!!!!11!!!!!!11!!!!!!11!!!!!!11!!!1!!!!!!11!!!!!"
>&2 echo "Running entrypoint.sh :: APP RUNNING !!!!!!!!!!11!!!!!"
>&2 echo "!!!11!!!!!!11!!!!!!11!!!!!!11!!!!!!11!!!1!!!!!!11!!!!!"
