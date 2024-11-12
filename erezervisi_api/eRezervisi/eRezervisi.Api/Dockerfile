FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 5269
ENV ASPNETCORE_URLS=http://+:5269

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY . .

FROM build AS publish
RUN dotnet publish "eRezervisi.Api/eRezervisi.Api.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
COPY ./eRezervisi.Api/Uploads/Images ./Uploads/Images

ENTRYPOINT ["dotnet", "eRezervisi.Api.dll"]