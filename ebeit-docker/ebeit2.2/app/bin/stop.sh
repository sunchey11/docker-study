#oracle db server
#java -Debeit.context=/spd -Djdbc.driverClassName=oracle.jdbc.OracleDriver -Djdbc.url=jdbc:oracle:thin:@192.168.1.20:1521:dbserver -Djdbc.username=spdtest -Djdbc.password=spdtest -Djava.ext.dirs=../lib:../bundles:$JAVA_HOME/jre/lib/ext com.ebig.ebeit.ui.utils.LaunchWeb
#mysql
export PATH=/usr/java/latest/bin:/usr/local/apache-maven/bin:$PATH
export JAVA_HOME=/usr/java/latest

java -Debeit.stop.port=12279 -cp .:../ebeitlib/*:../productlib/*:../lib/* com.ebig.ebeit.framework.utils.ShutdownWeb

