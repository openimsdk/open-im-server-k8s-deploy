# minio集群helm charts部署文档
## 部署步骤
### 1. 创建namespace
```
kubectl create ns minio
```
### 2. 创建kafka storageClass
```
kubectl apply -f ./sc.yaml;
```

### 3. 修改values.yaml
values.yaml常用参数说明
|参数名   | 参数值|  参数说明    |
|  ----  | ----  | --- |
| mode | standalone | 部署模式: standalone or distributed |
| auth.rootUser | admin | minio管理员账号 |
| auth.rootPassword|  openIMExamplePwd  | minio管理员密码 |
| statefulset.replicaCount | 4 | 分布式部署下，实例必须大于4个 |
| defaultBuckets | "app, openim" | 默认创建桶名 |
| ingress | | console ingress配置 | 
| apiIngress | | api ingress配置  |
| persistence.size | 200Gi | pv最大size |
|global.storageClass| minio-data-sc |存储类名，需要和sc.yaml中storageClass保持一致|


### 3. 安装minio分片集群
安装minio集群
```
helm install minio-cluster -f values.yaml bitnami/minio -n minio
```

卸载minio集群
```
helm delete minio-cluster -n minio
```