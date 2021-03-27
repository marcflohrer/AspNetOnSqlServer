FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
ARG ConnectionString=default_connection_string
ENV ConnectionString=$ConnectionString
WORKDIR /app
COPY . .
RUN ["dotnet", "restore"]
RUN ["dotnet", "build"]
RUN chmod +x ./entrypoint.sh
FROM build AS publish
RUN ["dotnet", "publish", "app.csproj", "-c", "Release", "-o", "/app" ]
FROM publish AS final
ENV ASPNETCORE_ENVIRONMENT=Development
ENV ASPNETCORE_URLS=http://+:6003;https://+:6004  
EXPOSE 6003 6004
WORKDIR /app

COPY --from=publish /app/entrypoint.sh .
COPY --from=publish /app .
COPY --from=publish /app/etc/ssl/openssl.cnf /etc/ssl/openssl.cnf

ENTRYPOINT ./entrypoint.sh ${ConnectionString}
