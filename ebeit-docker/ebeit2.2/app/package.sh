# rm -r ~/.m2/repository/com/ebig
# ls ~/.m2/repository/com/ebig
# export PATH=/usr/java/latest/bin:/usr/local/apache-maven/bin:$PATH
# export JAVA_HOME=/usr/java/latest

#将此目录下关于备份的目录名字放入一个数组之中
j=0
for i in `ls | grep libback`
do
	folder_list[j]=$i
	j=`expr $j + 1`
done

#如果目前用于存储备份的目录个数大于4，就需要找到最旧的那个删除掉
if [ "${#folder_list[@]}" -gt "4" ]
	then 
    echo 'need clean backup'
		k=0
		for str in $folder_list
		do
			substr=${str#*libbackup}
			foldertime_list[k]=$substr
			k=`expr $k + 1`
		done
		
		mixtime=${foldertime_list[0]}
		for timestr in $foldertime_list
		do
			if [ $mixtime -gt $timestr ] 
			then 
				mixtime=$timestr
			fi
		done
		
		deletename='libbackup'$mixtime
		if [ -e "$deletename" ]
		then 
			echo 'delete file:'$deletename
			rm -rf ./$deletename
		fi
fi

# rm -rf ./target

#创建平台lib，产品lib以及备份目录
mkdir -p ebeitlib
mkdir -p productlib
# if [ -e "lib" ]
# then
#   libbackupname="libbackup"`stat lib | grep -i Modify | awk -F. '{print $1}' | awk '{print $2$3}'| awk -F- '{print $1$2$3}' | awk -F: '{print $1$2$3}'`
# else
#   libbackupname="libbackup"`date +%Y%m%d%H%M%S`
# fi
# mkdir -p $libbackupname

#将上一次下载的jar移动到新创建的备份目录中
# mv lib/* $libbackupname
# mv ebeitlib/* $libbackupname
# mv productlib/* $libbackupname

echo ******************************
#maven下载依赖到lib目录
mvn -s ./maven-settings.xml dependency:copy-dependencies -DoutputDirectory=lib

#如果存在这两个txt文件，就是希望将不同jar分开存放
if [ -e "ebeitlibarray.txt" ] 
then 
	ebeitLibArray=`cat ebeitlibarray.txt`

	for ebeitfile in $ebeitLibArray
	do
		mv lib/$ebeitfile*.jar ebeitlib
	done
fi

# if [ -e "productlibarray.txt" ] 
# then 
# 	productLibArray=`cat productlibarray.txt`

# 	for productfile in $productLibArray
# 	do
# 		mv lib/$productfile*.jar productlib
# 	done
# fi

