#!/bin/bash

/usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf
./nginx -s reload 热更新

                   .::::.
                 .::::::::.
                :::::::::::
             ..:::::::::::'
          '::::::::::::'
            .::::::::::
       '::::::::::::::..
            ..::::::::::::.
          ``::::::::::::::::
           ::::``:::::::::'        .:::.
          ::::'   ':::::'       .::::::::.
        .::::'      ::::     .:::::::'::::.
       .:::'       :::::  .::::::::'  ':::::.
      .::'        :::::.:::::::::'      ':::::.
     .::'         ::::::::::::::'         ``::::.
 ...:::           ::::::::::::'              ``::.
```` ':.          ':::::::::'                  ::::..
                   '.:::::'                    ':'````..


[root@hadoop01 ~]# vim /etc/issue
[root@hadoop01 ~]# vim /etc/motd

更改文件的所属组 
chgrp [组名] [文件名]

参数-R 递归到每个子文件
chgrp -R [组名] [目录]


更改文件的所有者
chown [用户] [文件名]

参数-R 递归到每个子文件
chown -R [用户] [目录]
chown -R virftp:virftp /home/virftp

默认文件权限
目录755
文件644

umask 可改变文件的默认权限
umask xxx (xxx代表三个数字)
umask 的值是0022

如果umask没有预设值
目录777
文件644
如果设置了默认值0022

目录 777-0022=755
文件 666-0022=644


修改设置文件的特殊属性

chattr [+-=] [Asaci] [文件|目录] 

读取文件或者目录的特殊权限
lsattr [-aR] [文件|目录]

查找文件


模糊查找
whereis [-bms] [文件名称]
-b 查找二进制
-m 之查找帮助文件
-s 查找源代码文件


find [路径] [参数]

参数
-atime +n|-n 表示访问或执行时间            大于或小于N天的文件  读取执行更改
-ctime +n|-n 表示写入 更改inode属性的时间  大于或小于N天的文件  写入文件 更改所有者 权限 链接设置
-mtime +n|-n 表示写入时间                  大于或小于N天的文件  写入文件时更改

find . -name "文件名*" -type d


ln [-s] [来源文件] [目的文件]
加-s    建立软连接
不加-s  建立硬链接



软件安装

源码包 之后编译成 rpm包
二进制包（RPM包）

安装方式不同
rpm包 安装松散 到处都是
源码包 制定/usr/local/软件名

安装后的区别 就是安装位置不同

源码包的保存位置 /usr/local/src
源码包的安装位置 /usr/local

./configure 软件配置与检查
1、定义需要的功能选项
2、检测系统环境是否符合安装要求
3、把定义好的功能选项和检测系统环境信息都写入Makefile文件，用于后续的编辑


1、文件基本权限
	基本权限的修改
	-文件
	d目录
	l软链接

	权限的作用
	对文件来说 最高权限是x 
	对目录来说 最高权限是w 只能赋予 0 5 7权限
	

	其他权限命令


2、文件默认权限
3、ACL权限

查看有没有ACL权限
命令 dumpe2fs -h /dev/vda1
查看属性 Default mount options:    user_xattr acl

没有上面的属性 就要临时挂载
mount -o remount,acl / 

永久生效ACL
vi /etc/fstab
UUID=c2ca6f--------一串编码
mount -o remount /

setfacl -[m,x] [u,g]:username:[r,w,x] 文件名 

setfacl -b 文件名  //删除文件名上的所有ACL权限

m设置
x删除
u用户
g用户组
o其它

getfacl 文件名 获取文件acl权限

setfacl -[m,x] [u,g]:username:[r,w,x] -R 文件名  //递归到每一个子文件
setfacl -[m,x] [d]:[u,g]:username:[r,w,x] 目录名 //默认权限 之后创建的ACL文件权限


4、文件特殊权限
5、不可改变位权限
6、sudo权限
sudo权限 赋予普通用户的执行命令
sudo权限 赋予普通用户的指定的执行命令

SetUID
4755
chmod u+s 文件名
SetUID是危险的权限
要保存日志
些shell脚本 检测保存日志
输出报错日志

SetGID 
2755
chmod g+s 文件名/目录名

设置粘着位
1755
chmod o+s 目录名

Linux不可改变位权限
chattr +[a i]

lsattr 查看



cut 列提取
cut [选项] 文件名
-f 提取第几行
-d 按照指定分割符分割列
cut是用来截取数据带有指定分隔符的行 否则不能截取成功


printf 输出类型输出格式

awk '条件1{动作1}条件2{动作2}'
没有条件的话 直接执行动作

printf '\n' 等于 print

awk 'BEGIN{动作1}{动作2}'
awk 'BEGIN{FS=":"}{print$1}'

FS=":" 指定分隔符为: 默认的分隔符是制表符 也就是tab键

sed字符替换命令
选取、替换、删除、新增

sed [选项] '[动作]' 文件名
sed [选项] '[动作]' 文件名
选项 
-n 指定行

-e 识别多个动作
-i 会修改原始文档

动作 
a 追加
c 行替换
i 插入
p 打印
s 字符串替换 行范围s/旧字符串/新字符串/g

sed -n '2p' 打印第二行

sort [选项] 文件名
-f 忽略大小写
-n 以数值型进行排序
-r 反向排序
-t 指定分隔符 默认的分隔符是制表符
-k n[,m] 按照指定的字段范围排序 从第n字段开始 m地段结束

wc [选项] 文件名 
统计命令
-l 只统计行数
-w 只统计单词数
-m 指统计字符数


kill -9 nginx的PID
/usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf


ps -ef | grep 'nginx: master' | grep -v 'grep' | wc -l


ajax异步触发： 通过php的exec执行外部linux命令 触发某个php文件
死循环
定时任务
守护进行 

订单系统架构设计

runlevel 查看当前系统运行级别
3 5 当前是5

init 设置系统当前运行级别

/etc/inittab 开机运行级别配置文件

chkconfig --list 查看系统服务自启动状态 可以看到所有RPM包安装的服务
源码包安装的服务 一般安装在/usr/local下


RPM包主要安装在这些地方
/etc/init.d/      启动脚本位置
/etc/sysconfig/   初始化环境配置文件位置
/etc/             配置文件位置
/etc/xinetd.conf  配置文件
/etc/xinetd.d     启动脚本
/var/lib/         服务产生的数据
/var/log/         服务产生的日志
										   |---- 独立的服务      在内存中
										   |
			|------	PRM包默认安装的服务----|
			|							   |
Linux服务---|							   |---- 基于xinetd服务  xinetd本身占内容 守护的服务 不占内存
			|
			|
			|------ 源码包安装的服务 （/usr/local） 


主要了解独立的启动方法和源码包的启动和自启动方法

启动：就是在当前系统中让服务运行。并提供功能
自启动：服务在系统开机或重启之后，随着西戎的启动而自动启动服务

由于安装位置的不同（PRM和源码包）所以启动方式不同

ps aux 查看当前系统中 运行的服务

一个ip地址 可以有65535个端口

/etc/services  查看常规端口的

netstat -tlump 会罗列出系统所有已经启动的服务

-t 列出tcp数据
-u 列出udp数据
-l 列出正在监听的网络服务
-n 用端口号显示服务
-p 列出该服务的进程id


可以看到所有RPM包安装的服务/etc/init.d/独立服务名  start|stop|restart|status


独立服务自启动的三种方式

方式一
chkconfig --level 独立服务名 [on|off]

chkconfig --list | grep mysql 查看

chkconfig --level 2345 mysql on 设置

方式二
修改/etc/rc.d/rc.local文件
加入开机启动脚本

方式三（同方式一管理一种自启动方式）
使用ntsysv命令管理自启动



源码包不能实别 service、chkconfig、ntsysv 这种命令

可以用 [其实都是用绝对路径知道启动脚本]

/usr/local/nginx/sbin/nginx stop|start 


如何让源码包的nginx服务 让service命令管理启动
方法1、讲启动脚本 cp到/etc/init.d/目录下
方法2、chkconfig --add nginx

操作以后 源码包和RPM包一样了


进程管理的作用

1、判断服务器的健康状态
2、查看系统中所有进程
3、杀死进程

ps aux 
查看系统中所有进程

ps -le
查看系统中所有进程

USER 用户
PID  进程id
CPU  占用cpu百分比
MEM  占用物理内存百分比
VSZ  占用虚拟内存kb
RSS  占用实际物理内存kb
TTY  在哪个终端运行
STAT  进程状态
	R 运行
	S 睡眠
	T 停止状态
	s 包含子进程
	+ 位于后台
START 进程的启动时间
TIME 进程占用CPU的运算时间 注意不是系统时间
COMMAND 产生此进程的命令名


top [选项]
-d 指定命令每隔几秒更新
-bn 
P 以CPU使用率排序
M 以内存的使用率排序
N 以PID排序
q 退出top



在我的服务器 安装phpmyadmin

路由
中间件
验证器
控制器


ps 所有进程
pstree 查看进程树
top 查看进程健康状态


kill -l 查看所有管理进程的方式
kill -1 进程号 此命令不会重启服务 会重新加载服务配置文件
kill -9 进程号 强制终止

killall [选项][信号] 进程名
-i 交互式 询问是否要杀死的某个进程
-I 忽略进程名的大小写

pkill [选项][信号] 进程名
-t 终端号 按照终端号提出用户


ps -le
优先级 数字越小 代表该进程优先级也越高
PRI  不可改变 系统制定
NI   可改变 用户可设置 普通用户只能设置 0 至 19 超级用户可以设置为 - 负
NI   -20 至 10

PRI = PRI + NI
最终数值越小的 优先级越高


nice [选项] 
只能改之后新的程序的进程优先级 不能改当前启动的程序的进程优先级
nice -n -5 service nginx start

工作管理
工作管理简介
1、当前的登陆终端 只能管理当前终端的工作 而不能 管理其他终端的工作
2、放入后台的命令必须可以持续运行一段时间 这样我们才能朴拙和操作这个工作
3、放入后台执行的命令不能和前台用户有交互或需要前台输入，否则放入后台只能暂停 而不能执行

工作管理方法
后台命令脱离登陆终端执行

查看后台工作的程序
jobs -l 

把进程放入后台
1、命令 &       这种方式会在后台执行
   例 find / &

2、命令
   运行后 按下 ctrl + z 快捷键 放在后台暂停



后台命令脱离登陆终端执行的方法
1、需要后台执行的命令加入/etc/rc.local文件中
2、使用系统定时任务 让系统在制定的时间执行某个后台命令
3、使用nohup命令 

vmstat  1  3 命令监控系统资源
每隔一秒刷新一次 一共刷新三次

cache 是用来加速数据从硬盘中读取的
buffer 是用来加速数据写入硬盘的

dmesg 开机时内核检测信息

dmesg | grep CPU

free 查看内存使用状态
free 

uptime 显示系统的启动时间和平均负载    也就是top命令的第一行   w命令也可以看到这个数据

uname -a


lsof | more 查询系统中所有进程调用的文件

lsof /sbin/int 查询某个文件被哪个进程调用

lsof -c httpd 查看httpd进程调用了哪些文件

lsof -u root 按照用户名 查询某用户的进程调用的文件