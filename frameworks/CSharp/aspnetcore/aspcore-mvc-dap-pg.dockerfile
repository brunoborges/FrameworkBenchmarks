FROM mcr.microsoft.com/dotnet/core/sdk:5.0 AS build
WORKDIR /app
COPY Benchmarks .
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/core/aspnet:5.0 AS runtime
ENV ASPNETCORE_URLS http://+:8080
WORKDIR /app
COPY --from=build /app/out ./
COPY Benchmarks/appsettings.postgresql.json ./appsettings.json

ENTRYPOINT ["dotnet", "Benchmarks.dll", "scenarios=MvcDbSingleQueryDapper,MvcDbMultiQueryDapper,MvcDbFortunesDapper"]