set -u  
set -e  
# set -o errexit, set -o pipefail 认为失败, set +e
# rm -f 不存在不会报错
# mkdir -p 父目录不存在会创建它
# "$@"
# find -print0 | xargs -0 ls
# trap command signal [signal ...]



#Modify SELinux
#sed -i "s#`grep "^SELINUX=" /etc/sysconfig/selinux`#SELINUX=disabled#g" /etc/sysconfig/selinux
#sed -i "s#`grep "^SELINUX=" /etc/selinux/config`#SELINUX=disabled#g" /etc/selinux/config

#ncrease the server file descriptor
#echo -e "\n* soft core unlimited \n* soft nofile 65536 \n* hard nofile 65535 " >>/etc/security/limits.conf 

#echo "
##net.ipv4.tcp_fin_timeout = 30
##net.ipv4.tcp_keepalive_time = 1200
#net.ipv4.tcp_syncookies = 1
#net.ipv4.tcp_tw_reuse = 1
#net.ipv4.tcp_tw_recycle = 1
##net.ipv4.ip_local_port_range = 1024 65000
#net.nf_conntrack_max = 1310000
#net.netfilter.nf_conntrack_max = 1310000
#" >> /etc/sysctl.conf
#/sbin/sysctl -p >/dev/null 2>&1

echo 'ulimit -c unlimited' >>/etc/profile ; ulimit -c unlimited

yum -y update
yum -y upgrade
yum clean all
yum makecache
yum install -y dnf

# rpm and epel
OS_VER=`rpm -q centos-release | cut -d'-' -f3`
# centos7
if [ "$OS_VER" = 7 ]; then
	yum localinstall -y --nogpgcheck https://download1.rpmfusion.org/free/el/rpmfusion-free-release-7.noarch.rpm https://download1.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-7.noarch.rpm
	yum localinstall -y --nogpgcheck https://download1.rpmfusion.org/free/el/rpmfusion-free-release-7.noarch.rpm https://download1.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-7.noarch.rpm
	yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
	subscription-manager repos --enable "rhel-*-optional-rpms" --enable "rhel-*-extras-rpms"  --enable "rhel-ha-for-rhel-*-server-rpms"
elif [ "$OS_VER" = 8 ]; then
	dnf install -y --nogpgcheck https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
	dnf config-manager -y --enable PowerTools
	yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
	ARCH=$( /bin/arch )
	dnf config-manager -y --set-enabled PowerTools

elif [ "$OS_VER" = 6 ]; then
	sudo yum localinstall -y --nogpgcheck https://download1.rpmfusion.org/free/el/rpmfusion-free-release-6.noarch.rpm https://download1.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-6.noarch.rpm
	yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
fi

yum -y install mlocate 
yum -y install lrzsz
yum -y install redhat-lsb-core
yum -y install htop
yum -y install psmisc
yum -y install tree 
yum -y install tcpdump 
yum -y install cmake
yum -y install make 
yum -y install nc
yum -y install gcc
yum -y install gcc-c++
yum -y install python2
yum -y install sysstat 
yum -y install dstat 
yum -y install dos2unix 
yum -y install lrzsz 
yum -y install iotop 
yum -y install telnet 
yum -y install wget 
yum -y install ntp 
yum -y install ntpdate 
yum -y install git 
yum -y install iftop
yum -y install vim 
yum -y install gdb 
yum -y install lftp 
yum -y install mysql  
yum -y install curl
yum -y install curl-devel
yum -y install libxml2
yum -y install libxml2-devel
yum -y install valgrind
yum -y install zip
yum -y install unzip
yum -y install axel
yum -y install tar
yum -y install zlib
yum -y install pcre 
yum -y install openssl
yum -y install ntfs-3g
yum -y install expect
yum -y install epel-release 
yum -y install nload
yum -y install bmon
#yum -y install slurm
#yum -y install cbm
#yum -y install speedometer
#yum -y install netload
yum -y install bwm-ng
yum -y install vnstat
yum -y install ifstat
yum -y install dstat
yum -y install collectl
yum -y install iftop
yum -y install iptraf
yum -y install tcptrack
yum -y install pktstat
yum -y install netwatch
# 直接根据进程查看网络数据报
yum -y install trafshow
yum -y install nethogs
yum -y install atop
yum -y install ethtool
yum -y install iotop
yum -y install iperf
yum -y install openssl-devel

# shell
yum -y install zsh
command -v zsh | tee -a /etc/shells
chsh -s "$(command -v zsh)" "${USER}"
# zsh-newuser-install zsh 初始化命令
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# jdk
yum -y install java-1.8.0-openjdk
yum -y install java-1.8.0-openjdk-devel

# php
# yum search php
yum -y install php-mysqlnd php-pdo
yum -y install php-gd php-ldap php-odbc php-pear php-xml php-xmlrpc php-mbstring php-soap curl curl-devel

# docker
yum install -y container-selinux
yum remove docker \
	docker-client \
	docker-client-latest \
	docker-common \
	docker-latest \
	docker-latest-logrotate \
	docker-logrotate \
	docker-engine
yum install -y yum-utils \
	  device-mapper-persistent-data \
	    lvm2
sudo yum-config-manager \
	    --add-repo \
	        https://download.docker.com/linux/centos/docker-ce.repo
if [ -r "containerd.io-1.2.6-3.3.el7.x86_64.rpm" ]; then
	echo "exist containerd.io-1.2.6-3.3.el7.x86_64.rpm"
else
	wget https://download.docker.com/linux/centos/7/x86_64/stable/Packages/containerd.io-1.2.6-3.3.el7.x86_64.rpm
fi
rpm -ivh containerd.io-1.2.6-3.3.el7.x86_64.rpm
yum install -y containerd.io docker-ce-cli docker-ce 


# timezone select
rm -f /etc/localtime
ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
# lua
dnf install readline-devel
