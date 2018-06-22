# Docker
Get Started with Docker
FROM microsoft/aspnetcore-build AS build
WORKDIR /app

COPY *.csproj .
RUN dotnet restore

COPY . .

RUN dotnet publish --output /app/ --configuration Release

FROM microsoft/aspnetcore AS final
WORKDIR /app
COPY --from=build /app .
ENTRYPOINT [ "dotnet", "TestProject.dll" ]

---
FROM microsoft/aspnetcore-build
WORKDIR /app

COPY publish .

ENTRYPOINT [ "dotnet", "TestProject.dll" ]

## Working steps to map publish folder to container

1. dockerfile

FROM microsoft/aspnetcore-build
WORKDIR /app

ENTRYPOINT [ "dotnet", "TestProject.dll" ]

2. command to build image
docker build -t volume-test .

3. run the container from image
docker run -it -p 8001:80 -v D:/Projects/TestProject/publish:/app --name volume-test volume-test

4. Result

D:\Projects\Test>docker build -t docker-test .
Sending build context to Docker daemon   3.14MB
Step 1/3 : FROM microsoft/aspnetcore-build AS base
 ---> e4e43a027c0b
Step 2/3 : WORKDIR /app
 ---> Using cache
 ---> 004da0c50e7c
Step 3/3 : ENTRYPOINT [ "dotnet", "Test.dll" ]
 ---> Running in 4808106b8898
Removing intermediate container 4808106b8898
 ---> 03648c023ca4
Successfully built 03648c023ca4
Successfully tagged docker-test:latest
SECURITY WARNING: You are building a Docker image from Windows against a non-Windows Docker host. All files and directories added to build context will have '-rwxr-xr-x' permissions. It is recommended to double check and reset permissions for sensitive files and directories.

D:\Projects\Test>docker run -it -p 9001:80 -v D:\Projects\Test\publish:/app --name docker-test docker-test
Hosting environment: Production
Content root path: /app
Now listening on: http://[::]:80