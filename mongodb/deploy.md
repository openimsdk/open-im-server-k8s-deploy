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
#### 1. values.yaml常用参数说明
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

#### 2. config server pod 非亲和性
app.kubernetes.io/component: configsvr
##### 1. 保证config server的pod不会被调度到同一个node上运行
```
podAntiAffinity:
  requiredDuringSchedulingIgnoredDuringExecution:
    - topologyKey: kubernetes.io/hostname
      labelSelector:
        matchExpressions: 
          - key: app.kubernetes.io/component
            operator: In 
            values: 
            - configsvr
```
##### 2. 尽量保证config server的pod不会被调度到同一个node上运行，如果无法满足这个规则，也会将config server调度到同一个node
```
podAntiAffinity:
  preferredDuringSchedulingIgnoredDuringExecution:
  - weight: 100
    podAffinityTerm:
      labelSelector:
        matchExpressions:
        - key: app.kubernetes.io/component
          operator: In
          values:
          - configsvr
      topologyKey: kubernetes.io/hostname
```

#### 3. mongos pod 非亲和性
app.kubernetes.io/component: mongos
##### 1. 保证mongos的pod不会被调度到同一个node上运行
```
podAntiAffinity:
  requiredDuringSchedulingIgnoredDuringExecution:
    - topologyKey: kubernetes.io/hostname
      labelSelector:
        matchExpressions: 
          - key: app.kubernetes.io/component
            operator: In 
            values: 
            - mongos
```
##### 2. 尽量保证mongos的pod不会被调度到同一个node上运行，如果无法满足这个规则，也会将mongos调度到同一个node
```
podAntiAffinity:
  preferredDuringSchedulingIgnoredDuringExecution:
  - weight: 100
    podAffinityTerm:
      labelSelector:
        matchExpressions:
        - key: app.kubernetes.io/component
          operator: In
          values:
          - mongos
      topologyKey: kubernetes.io/hostname
```

#### 4. mongo shard pod 非亲和性
app.kubernetes.io/component: shardsvr
##### 1. 保证mongos的pod不会被调度到同一个node上运行
```
podAntiAffinity:
  requiredDuringSchedulingIgnoredDuringExecution:
    - topologyKey: kubernetes.io/hostname
      labelSelector:
        matchExpressions: 
          - key: app.kubernetes.io/component
            operator: In 
            values: 
            - mongos
```
##### 2. 尽量保证mongos的pod不会被调度到同一个node上运行，如果无法满足这个规则，也会将mongos调度到同一个node
```
podAntiAffinity:
  preferredDuringSchedulingIgnoredDuringExecution:
  - weight: 100
    podAffinityTerm:
      labelSelector:
        matchExpressions:
        - key: app.kubernetes.io/component
          operator: In
          values:
          - mongos
      topologyKey: kubernetes.io/hostname
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