###整体执行流程

#---------- 只是修改环境变量的两个文件是 ./environment.sh ./make_etcd-0.sh --------------#

#建立 env 信息
source ./environment.sh
#分发集群环境变量定义脚本
./cp_env.sh


#创建 TLS 证书和秘钥, 若已经下载安装，此步注释`
#./make_ca.sh
#分发证书和秘钥 
./make_pem.sh 


#设置etcd环境变量， 第一个参数就是etcd 服务的name etcd-host0 后面的这个数字 
source  ./make_etcd-$1.sh
#source  ./make_etcd-1.sh
#source  ./make_etcd-2.sh


#安装etcd服务 
./install_etcd.sh
#生成etcd服务系统配置
./set_etcd.sh
#启动etcd服务
./start_etcd.sh 
#验证etcd服务
./verify_etcd.sh  



#安装kube
./install_kube.sh
#创建kube ca文件
./make_kube_ca.sh
#创建kube配置文件
./make_kube_config.sh



#创建flanneld ca证书 
./make_flannel_ca.sh 
#创建flanneld pod 网络 
./make_flannel_network.sh  
#安装flanneld  
./install_flanneld.sh 
#生成flanneld 启动service 文件  
./make_flannel_system.service.sh  
#启动flanneld
./start_flannel.sh 



#运行 kube  master  apiserver
./start_kube-apiserver.sh 
#运行 kube controller manager  
./start_kube-controller-manager.sh
#运行 kube scheduler 
./start_kube-scheduler.sh
















