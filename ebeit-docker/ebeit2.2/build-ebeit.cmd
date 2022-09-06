docker build -t ebeit-docker .

docker run --network ebeit-net --name ebeit_demo --rm -it -p 2279:2279 ebeit-docker /bin/sh 

docker run -it --network ebeit-net nicolaka/netshoot
