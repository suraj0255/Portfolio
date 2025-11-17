# -------------------------
# Build stage
# -------------------------
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src

# Copy only project file to leverage Docker cache
COPY Personal_Portfolio/Personal_Portfolio.csproj Personal_Portfolio/

# Restore dependencies
RUN dotnet restore Personal_Portfolio/Personal_Portfolio.csproj

# Copy all source code
COPY Personal_Portfolio/. Personal_Portfolio/

# Publish the project
RUN dotnet publish Personal_Portfolio/Personal_Portfolio.csproj -c Release -o /app/publish

# -------------------------
# Runtime stage
# -------------------------
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS runtime
WORKDIR /app

# Copy publish output from build stage
COPY --from=build /app/publish .

# Environment & port
ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080

# Start the app
ENTRYPOINT ["dotnet", "Personal_Portfolio.dll"]
