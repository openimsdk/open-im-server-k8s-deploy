# mongo(3分片1副本集群)helm charts部署文档
## 部署步骤
### 1. 创建namespace
```
kubectl create ns mongo
```
### 2. 创建kafka storageClass
```
kubectl apply -f ./sc.yaml;
```

### 3. 修改values.yaml
values.yaml常用参数说明
|参数名   | 参数值|  参数说明    |
|  ----  | ----  | --- |
| auth.rootUser | root | mongoDB用户名 |
| auth.rootPassword | openIMExamplePwd | mongoDB密码 |
| configsvr.replicaCount|  3  | config server实例数 |
| shards | 3 | 分片数|
| mongos.replicaCount | 3 | mongos实例数 |
| shardsvr.dataNode.replicaCount | 2 | 分片副本总数 | 
|global.storageClass| mongo-data-sc |存储类名，需要和sc.yaml中storageClass保持一致|


### 3. 安装mongo分片集群
安装mongo集群
```
helm install mongo-shared-cluster -f values.yaml bitnami/mongodb-sharded -n mongo
```

卸载mongo集群
```
helm delete mongo-shared-cluster -n mongo
```

通过values.yaml更新mongo集群
```
helm upgrade mongo-shared-cluster  bitnami/mongodb-sharded -f values.yaml -n mongo
```