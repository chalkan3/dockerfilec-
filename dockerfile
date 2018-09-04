FROM microsoft/dotnet:2.1-sdk-alpine AS build-env
WORKDIR /app

# Copiar csproj e restaurar dependencias
COPY . .
RUN dotnet restore
RUN dotnet publish -c Release -o out

# Build da imagem
FROM microsoft/dotnet:2.1-aspnetcore-runtime-alpine
WORKDIR /app
COPY --from=build-env /app/out .

ENTRYPOINT ["dotnet", "aspnetcordemo.dll"]