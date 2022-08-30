FROM microsoft/dotnet:2.1-aspnetcore-runtime AS base
WORKDIR /app

FROM microsoft/dotnet:2.1-sdk AS build
ARG buildno
WORKDIR /src
COPY . .

#Copy all the certificates - for all environment
RUN cp nexus.crt /usr/local/share/ca-certificates/nexus.crt
RUN cp ShawRootCA.crt /usr/local/share/ca-certificates/ShawRootCA.crt
RUN cp ShawCA1.crt /usr/local/share/ca-certificates/ShawCA1.crt
#Register the certificate on the linux box
RUN update-ca-certificates

WORKDIR /src/Common.Mongo.DataAccess
RUN dotnet restore -nowarn:msb3202,nu1503 
RUN dotnet build --no-restore -c Release /p:Version=${buildno}
RUN dotnet pack --no-build --no-restore -c Release /p:Version=${buildno}
RUN dotnet nuget push ./bin/Release/Common.Mongo.DataAccess.${buildno}.nupkg -k 22f6da5d-02b2-323f-b9b2-0f0198e9cbc0 -s "https://nexus.vcs.sjrb.ad/repository/nuget-hosted/"