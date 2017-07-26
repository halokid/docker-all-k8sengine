###整体执行流程


#建立 env 信息
source ./environment.sh
#分发集群环境变量定义脚本
./cp_env.sh


#创建 TLS 证书和秘钥, 若已经下载安装，此步注释`
#./make_ca.sh
#分发证书和秘钥 
./make_pem.sh 


#设置etcd环境变量
source  ./make_etcd-0.sh
#source  ./make_etcd-1.sh
#source  ./make_etcd-2.sh



#生成etcd服务
./set_etcd.sh
#启动etcd服务
./start_etcd.sh  










