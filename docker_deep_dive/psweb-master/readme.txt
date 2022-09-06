 docker image build -t test:latest .
 docker container run -d  --name web1 --publish 8080:8080 test:latest
 http://localhost:8080/