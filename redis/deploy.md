# redis集群helm charts部署文档
## 部署步骤
### 1. 创建namespace
```
kubectl create ns redis
```
### 2. 创建pvc和pv
```
kubectl apply -f ./pv.yaml;
kubectl apply -f ./pvc.yaml;
kubectl apply -f ./sc.yaml;
```

### 3. 修改values.yaml
values.yaml参数说明
|参数名   |   参数说明    |
|  ----  | ----  |
|cluster.nodes|为节点数量，包含主和从|
|cluster.replicas|为replicas数量|
| global.password| redis密码 |
| global.storageClass| 存储类名|


### 3. 安装redis集群
安装redis集群
```
helm install redis-cluster -f values.yaml bitnami/redis-cluster -n redis
```
卸载redis集群
```
helm delete redis-cluster -n redis
```
