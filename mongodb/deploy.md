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
| configsvr.affinity | |config server 亲和力 |
| mongos.affinity | | mongos 亲和力|


config server pod亲和性, 要求三台服务器上不会出现同一节点存在两个config server的情况
```
podAntiAffinity:
  requiredDuringSchedulingIgnoredDuringExecution:
    - topologyKey: kubernetes.io/hostname
      labelSelector:
        matchExpressions: 
          - key: configSvr
            operator: In 
            values: 
            - "true"
```

mongos pod亲和性, 要求三台服务器上不会出现同一节点存在两个mongos的情况
```
podAntiAffinity:
  requiredDuringSchedulingIgnoredDuringExecution:
    - topologyKey: kubernetes.io/hostname
      labelSelector:
        matchExpressions: 
          - key: mongos
            operator: In 
            values: 
            - "true"
```
该规则将在调度过程中强制要求MongoDB Shard主节点和副本节点不在同一节点上
```
podAntiAffinity:
  requiredDuringSchedulingIgnoredDuringExecution:
    - labelSelector:
        matchLabels:
          app: {{ template "mongodb.name" . }}-shard
          role: {{ template "mongodb.name" . }}-shard-mongodb
      topologyKey: "kubernetes.io/hostname"
```
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