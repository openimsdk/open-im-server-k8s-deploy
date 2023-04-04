# mysql(1主1从)helm charts部署文档
## 部署步骤
### 1. 创建namespace
```
kubectl create ns mysql
```
### 2. 创建mysql storageClass
```
kubectl apply -f ./sc.yaml;
```

### 3. 修改values.yaml
values.yaml常用参数说明
|参数名   | 参数值|  参数说明    |
|  ----  | ----  | --- |
| architecture| replication |mysql|
| auth.rootPassword| openIMExamplePwd  |mysql密码， 用户为root用户，可不填 |
| global.storageClass| mysql-data-sc |存储类名，需要和sc.yaml中storageClass保持一致|
| secondary.replicaCount	|1 |从节点数量


### 3. 安装mysql集群
安装mysql集群
```
helm install mysql-cluster -f values.yaml bitnami/mysql -n mysql
```

卸载mysql集群
```
helm delete mysql-cluster  -n mysql
```