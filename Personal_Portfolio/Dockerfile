# Build stage
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src

# Copy everything
COPY . .

# Restore + publish
RUN dotnet restore Personal_Portfolio/Personal_Portfolio.csproj
RUN dotnet publish Personal_Portfolio/Personal_Portfolio.csproj -c Release -o /app/publish

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS final
WORKDIR /app
COPY --from=build /app/publish .

# Expose port for Render
EXPOSE 8080

# Required for Render
ENV ASPNETCORE_URLS=http://+:8080

ENTRYPOINT ["dotnet", "Personal_Portfolio.dll"]
