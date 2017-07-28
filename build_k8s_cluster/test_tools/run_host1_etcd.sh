./etcd 
-name etcd0 
-advertise-client-urls http://${HOST}:2379,http://${HOST}:4001 
-listen-client-urls http://0.0.0.0:2379,http://0.0.0.0:4001 
-initial-advertise-peer-urls http://${HOST}:2380 
-listen-peer-urls http://0.0.0.0:2380 
-initial-cluster-token etcd-cluster-1 
-initial-cluster etcd0=http://${HOST1}:2380,etcd1=http://${HOST2}:2380,etcd2=http://${HOST3}:2380 
-initial-cluster-state new &


