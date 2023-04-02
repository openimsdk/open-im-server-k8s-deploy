# redis集群helm部署文档
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
|参数名|参数说明|
|  ----  | ----  |
|cluster.nodes|为主节点数量|

### 3. 安装redis集群
安装redis集群
```
helm install redis-cluster -f values.yaml bitnami/redis-cluster -n redis
```
卸载redis集群
```
helm delete redis-cluster -n redis
```
