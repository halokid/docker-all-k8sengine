./etcd
-name etcd0
-advertise-client-urls http://10.86.20.60:2379,http://10.86.20.60:4001
-listen-client-urls http://0.0.0.0:2379,http://0.0.0.0:4001 
-initial-advertise-peer-urls http://10.86.20.60:2380
-listen-peer-urls http://0.0.0.0:2380 
-initial-cluster-token etcd-cluster-1
-initial-cluster etcd0=http://10.86.20.57:2380,etcd1=http://10.86.20.60:2380
-initial-cluster-state new &


