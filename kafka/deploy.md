# kafka(3 broker)helm charts部署文档
## 部署步骤
### 1. 创建namespace
```
kubectl create ns kafka
```
### 2. 创建kafka storageClass
```
kubectl apply -f ./sc.yaml;
```

### 3. 修改values.yaml
values.yaml常用参数说明
|参数名   | 参数值|  参数说明    |
|  ----  | ----  | --- |
| zookeeperChrootPath | "zookeeper-cluster-0.zookeeper-cluster-headless.zookeeper", "zookeeper-cluster-1.zookeeper-cluster-headless.zookeeper", "zookeeper-cluster-2.zookeeper-cluster-headless.zookeeper" | k8s集群内部zk地址 |
| provisioning.topics|  name: ws2ms_chat partitions: 12 replicationFactor: 1  | kafka topic分区数， 副本数 |
|global.storageClass| mysql-data-sc |存储类名，需要和sc.yaml中storageClass保持一致|


### 3. 安装mysql集群
安装mysql集群
```
helm install kafka-cluster -f values.yaml bitnami/kafka -n kafka
```

卸载mysql集群
```
helm delete kafka-cluster -n kafka
```


