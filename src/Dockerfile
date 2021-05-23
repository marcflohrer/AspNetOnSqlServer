FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
ARG ConnectionString=default_connection_string
ENV ConnectionString=$ConnectionString
WORKDIR /app
COPY my-demo-app.csproj .
RUN dotnet restore my-demo-app.csproj
COPY . .
RUN dotnet build my-demo-app.csproj

FROM build AS publish
RUN dotnet publish -c Release -o /app my-demo-app.csproj

FROM mcr.microsoft.com/dotnet/sdk:5.0 AS final
ARG ConnectionString=default_connection_string
ENV ConnectionString=$ConnectionString

ENV ASPNETCORE_ENVIRONMENT=Development
ENV ASPNETCORE_URLS=http://+:6003;https://+:6004  
EXPOSE 6003 6004
WORKDIR /app

COPY --from=publish /app/entrypoint.sh .
COPY --from=publish /app .
COPY --from=publish /app/etc/ssl/openssl.cnf /etc/ssl/openssl.cnf


ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=false    

ENTRYPOINT bash ./entrypoint.sh $ConnectionString
