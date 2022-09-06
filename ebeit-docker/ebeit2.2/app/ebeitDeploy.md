# ebeit2.0部署教程
###1、准备部署环境
需要安装的有：
* java环境:jdk1.8版本
* maven:maven3.6.3
* mongodb:4.2.13
* mysql:5.6.36
* oracle:Oracle Database 11g
* rocket-chat(非必须,使用即时通讯时必需):任意版本
* activemq(非必须,使用jms消息时必需):5.15.9
###2、创建项目文件夹
新建一个文件夹起名为项目名字，并放入pom文件(项目运行所需要的依赖)以及package.sh脚本。
注意pom中需要有前台ui依赖。
package.sh中的内容也需要稍作修改，需要设置本服务器的环境变量：
```
export PATH=/usr/java/latest/bin:/usr/local/apache-maven/bin:$PATH  
#分别是java命令和maven命令的bin目录 
export JAVA_HOME=/usr/java/latest 
#设置java的安装目录
```
###3、运行package.sh，下载jar包
会将pom中的依赖下载下来自动放到lib文件夹中（如果没有lib文件夹会自动创建），package.sh执行后根据pom.xml自动创建lib文件夹并下载jar包到lib目录中
###4、项目文件夹中创建bin目录
需要有bin目录，bin目录中至少需要有三个脚本：start.sh、stop.sh以及nohub.sh，注意修改其中的环境变量(和package.sh中的类似)，端口号和项目名。
例如start.sh脚本:
```
export PATH=/usr/java/latest/bin:/usr/local/apache-maven/bin:$PATH
export JAVA_HOME=/usr/java/latest
java  -Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=22279  -Xms128M -Xmx1024M -Dfile.encoding=utf-8 -Ddruid.maxActive=200 -Dorg.eclipse.jetty.server.Request.maxFormContentSize=10000000 -Djava.awt.headless=true -Djava.net.preferIPv4Stack=true -Debeit.launchBrowser=false  -Debeit.port=2279 -Debeit.stop.port=12279 -Debeit.context=/ebeit-react-func  -cp .:../lib/* com.ebig.ebeit.framework.utils.LaunchWeb
#其中需要修改的基本上就是环境变量，端口号和项目名
#address=22279远程调试端口
#-Debeit.port=2279是启动端口
#-Debeit.stop.port=12279是停止端口，一般就是启动端口前面加一个1
#-Debeit.context=/ebeit-react-func是项目的访问名
```
注意start.sh和stop.sh中的停止端口需要一致。
start.sh中各个参数解读：
| 参数名称|参数解释|
|----------|----------|
| -Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=22279 | 开启远程调试模式，address是远程调试端口 |
| -Xms128M | 最小运行所需内存 |
| -Xmx1024M | 最大运行内存 |
| -Dfile.encoding=utf-8 | 编码 |
| -Ddruid.maxActive=200 | 数据库连接池最大连接数 |
| -Dorg.eclipse.jetty.server.Request.maxFormContentSize=10000000 | 一次请求最大接受体积，Byte为单位 |
| -Djava.awt.headless=true | 运行headless服务器处理图形元素 |
| -Debeit.launchBrowser | 完成后是否自动在浏览器打开 |
| -Debeit.port | 启动端口 |
| -Debeit.stop.port | 项目停止端口 |
| -Debeit.context | 项目启动名称 |
| -cp | 项目运行所需jar包的位置 |
nohup.sh中各个参数解读：
| 参数名称|参数解释|
|----------|----------|
| >/dev/null | 正常时不输出 |
| 2>/root/other/ebeit-react-func/bin/nohupError.log | 将错误信息输出到nohupError.log文件中 |
###5、放入配置文件
在bin目录下创建conf目录，将system.properties配置文件放入conf目录中，启动时会默认读取这个位置下的配置文件。
可能有某些配置需要根据情况进行修改，配置文件参数解读：
| 参数名称|解释|是否必填|
|----------|----------|----------|
| jdbc.driverClassName | 数据库驱动名称 |是|
| jdbc.url | 数据库连接地址 |是|
| jdbc.username | 数据库用户名 |是|
| jdbc.password | 数据库密码 |是|
| mongodb.host | mongo服务的主机地址 |是|
| mongodb.port | mongo服务端口，安装后默认是27017 |是|
| mongodb.dbname | mongo数据库名称 |否|
| mongodb.credentials | mongo凭证 | 否 |
| sysMenuTreeFactory | 主页面上显示的功能来源于插件还是数据库 |否|
| userDetailsServiceBeanRef | 使用内存登录还是数据库登录 |否|
| schemaUpdate | 是否跟随数据模型来更新数据库 |否|
| jms.enable | 是否开启jms消息服务 |否|
| jms.broker.url | jms服务地址 |否|
| system.id | 本系统id，不能重复 |否|
| system.title | 本系统名称 |否|
| rocket.chat.url | 即时通讯服务地址 |否|
###6、运行nohup.sh脚本启动项目
需要注意的是运行这个脚本后并没有什么提示，但是此时程序应该是正在启动，如果两分钟后还是无法访问项目，可能才是启动有问题。