# syntax=docker/dockerfile:1

# FROM maven:latest as base
FROM maven:3.3-jdk-8 as base     
WORKDIR /app

COPY app/pom.xml app/maven-settings.xml  ./

RUN mvn -s ./maven-settings.xml  dependency:resolve

COPY app/package.sh app/ebeitlibarray.txt app/productlibarray.txt ./
COPY app/bin ./bin
COPY app/ebeitlib ./ebeitlib
COPY app/productlib ./productlib
RUN ./package.sh
CMD ["/bin/bash"]


FROM maven:3.3-jdk-8
WORKDIR /app
COPY --from=base /app .
WORKDIR /app/bin

EXPOSE 2279
CMD ["./start.sh"]
# ENTRYPOINT ["/bin/sh"]




