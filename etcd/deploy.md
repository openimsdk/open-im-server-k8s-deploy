# etcd集群(3实例)helm charts部署文档
## 部署步骤
### 1. 创建namespace
```
kubectl create ns etcd
```
### 2. 创建etcd storageClass
```
kubectl apply -f ./sc.yaml;
```

### 3. 修改values.yaml
values.yaml常用参数说明
|参数名   |   参数说明    |
|  ----  | ----  |
| replicaCount|etcd实例数量|
| auth.rootPassword| etcd密码， 用户为root用户，可不填 |
| global.storageClass| 存储类名，需要和sc.yaml中storageClass保持一致|


### 3. 安装etcd集群
安装etcd集群
```
helm install etcd-cluster -f values.yaml bitnami/etcd -n etcd
```

卸载etcd集群
```
helm delete etcd-cluster  -n etcd
```
