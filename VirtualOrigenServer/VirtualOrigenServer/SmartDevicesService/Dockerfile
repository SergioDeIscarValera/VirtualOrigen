FROM mcr.microsoft.com/dotnet/aspnet:8.0.3-alpine3.18-arm32v7 AS runtime
WORKDIR /app
RUN apk add --no-cache tzdata
COPY ./bin/Release/net8.0/publish/* /app/
ENTRYPOINT ["dotnet", "SmartDevicesService.dll"]