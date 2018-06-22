FROM microsoft/aspnetcore-build AS base
WORKDIR /app

ENTRYPOINT [ "dotnet", "Test.dll" ]