# Test web-app to use with Pluralsight courses and Docker Deep Dive book
# Linux x64
# 原来是这段，但是无法装nodejs-npm
# FROM alpine

#我改成直接用node的镜像， 下面的安装nodejs和npm就没必要了
FROM node:16-alpine
LABEL maintainer="nigelpoulton@hotmail.com"

# Install Node and NPM
# RUN apk add --update nodejs nodejs-npm

# Copy app to /src
COPY . /src

WORKDIR /src

# Install dependencies
RUN  npm install

EXPOSE 8080

ENTRYPOINT ["node", "./app.js"]
