FROM mcr.microsoft.com/dotnet/aspnet:8.0.3-alpine3.18-arm32v7 AS runtime
WORKDIR /app
COPY ./bin/Release/net8.0/publish/* /app/
ENTRYPOINT ["dotnet", "VirtualOrigenServer.dll"]