docker run -d `
     --network ebeit-net --network-alias mysql `
     -v "$(pwd)/data:/var/lib/mysql" `
     -e MYSQL_ROOT_PASSWORD=Lrh13022958534 `
     -e MYSQL_DATABASE=ebeit_demo `
     --rm `
     --name ebeitdb `
     -p 24738:3306 `
     mysql:5.7