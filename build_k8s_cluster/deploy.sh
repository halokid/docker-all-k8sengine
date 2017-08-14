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
source  ./node1_env.sh

#source  ./make_etcd-1.sh
#source  ./node2_env.sh

#source  ./make_etcd-2.sh
#source  ./node3_env.sh


#安装etcd服务 
./install_etcd.sh
#生成etcd服务系统配置
./set_etcd.sh
#启动etcd服务
./start_etcd.sh 
#验证etcd服务
./verify_etcd.sh  



#安装kube
. install_kube.sh
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
# 清楚iptables规则
./clear_iptables.sh



#-----------------------  master is node1  ----------------------------
#运行 kube  master  apiserver
./start_kube-apiserver.sh 
#运行 kube master controller manager  
./start_kube-controller-manager.sh
#运行 kube master  scheduler 
./start_kube-scheduler.sh





#-----------------------  node2 ----------------------------
#set env varible
./node2_env.sh


#----------------------  node3 ----------------------------
#set env varible
./node3_env.sh


#----  至此如果是默认安装docker的， 应该已经配置好了 node节点的docker进程了 ---



#------------- 开始安装 kubelet, kubectl  等相关工具 ----------------
'''
$ wget https://dl.k8s.io/v1.6.2/kubernetes-server-linux-amd64.tar.gz
$ tar -xzvf kubernetes-server-linux-amd64.tar.gz
$ cd kubernetes
$ tar -xzvf  kubernetes-src.tar.gz
$ sudo cp -r ./server/bin/{kube-proxy,kubelet} /root/local/bin/ 
'''


#-------------------- 跑 kubelet 服务之前要进行下面的配置 ------------------------ START 
'''
kube node 节点正常运行，需要设置好三个地方， bootstrap.kubeconfig, kubelet.kubeconfig, kube-proxy.kubeconfig

其中 kubelet.kubeconfig 这个配置文件是由下面关于  kubelet  的命令自动生成的， 必须要先配置好 bootstrap.kubeconfig 之后，命令才可以正确生成这个文件

这三个地方的配置分别是
'''


'''
#-----------  bootstrap.kubeconfig --------------------


$ # 设置集群参数
$ kubectl config set-cluster kubernetes \
	  --certificate-authority=/etc/kubernetes/ssl/ca.pem \
		  --embed-certs=true \
			  --server=${KUBE_APISERVER} \
				  --kubeconfig=bootstrap.kubeconfig
$ # 设置客户端认证参数
$ kubectl config set-credentials kubelet-bootstrap \
	  --token=${BOOTSTRAP_TOKEN} \
		  --kubeconfig=bootstrap.kubeconfig
$ # 设置上下文参数
$ kubectl config set-context default \
	  --cluster=kubernetes \
		  --user=kubelet-bootstrap \
			  --kubeconfig=bootstrap.kubeconfig
$ # 设置默认上下文
$ kubectl config use-context default --kubeconfig=bootstrap.kubeconfig
$ mv bootstrap.kubeconfig /etc/kubernetes/ 

'''


'''
#-----------  kubelet.kubeconfig --------------------


查看未授权的 CSR 请求：

$ kubectl get csr
NAME        AGE       REQUESTOR           CONDITION
csr-2b308   4m        kubelet-bootstrap   Pending
$ kubectl get nodes
No resources found.
通过 CSR 请求：

$ kubectl certificate approve csr-2b308
certificatesigningrequest "csr-2b308" approved
$ kubectl get nodes
NAME        STATUS    AGE       VERSION
10.64.3.7   Ready     49m       v1.6.2
自动生成了 kubelet kubeconfig 文件和公私钥：

$ ls -l /etc/kubernetes/kubelet.kubeconfig
-rw------- 1 root root 2284 Apr  7 02:07 /etc/kubernetes/kubelet.kubeconfig
$ ls -l /etc/kubernetes/ssl/kubelet*
-rw-r--r-- 1 root root 1046 Apr  7 02:07 /etc/kubernetes/ssl/kubelet-client.crt
-rw------- 1 root root  227 Apr  7 02:04 /etc/kubernetes/ssl/kubelet-client.key
-rw-r--r-- 1 root root 1103 Apr  7 02:07 /etc/kubernetes/ssl/kubelet.crt
-rw------- 1 root root 1675 Apr  7 02:07 /etc/kubernetes/ssl/kubelet.key

这一步完成，应该就应该是添加进去node节点的了 ~~

其中应该会出现 node 是 notready  的情况

NAME          STATUS     AGE       VERSION
10.86.20.60   Ready      13d       v1.6.2
10.86.20.63   NotReady   16m       v1.6.2 


'''



'''
# --------------------  kube proxy -------------------------
跑这个就可以了
make_node3_kube_proxy_config
这个可能是要每个 node 都要真的跑一次的， 貌似是要生成 node 的一些加密主机信息的，不过这个自己看吧~我实践的是重新跑了一次哈


'''






#-------------------- 跑 kubelet 服务之前要进行下面的配置 ------------------------ END



#----- node2 ----------
./node2_start_kube.service.sh


#--- node3 ------------
./node3_start_kube.service.sh















