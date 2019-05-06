FROM mcr.microsoft.com/dotnet/core/aspnet:2.2 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/core/sdk:2.2 AS build
WORKDIR /src
COPY ["newdotnetapp.csproj", "."]
RUN dotnet restore "newdotnetapp.csproj"
COPY . .
RUN dotnet build "newdotnetapp.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "newdotnetapp.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "newdotnetapp.dll"]