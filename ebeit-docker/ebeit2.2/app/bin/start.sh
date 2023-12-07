export PATH=/usr/java/latest/bin:/usr/local/apache-maven/bin:$PATH
export JAVA_HOME=/usr/java/latest
# mysql启动的有点慢，要在它后面执行
sleep 3
java  -Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=22279  -Xms128M -Xmx1024M -Dfile.encoding=utf-8 -Ddruid.maxActive=200 -Dorg.eclipse.jetty.server.Request.maxFormContentSize=10000000 -Djava.awt.headless=true -Debeit.launchBrowser=false  -Debeit.port=2279 -Debeit.stop.port=12279 -Debeit.context=/ebeit_demo  -cp .:../ebeitlib/*:../productlib/*:../lib/* com.ebig.ebeit.framework.utils.LaunchWeb  




