# zookeeper集群(3实例)helm charts部署文档
## 部署步骤
### 1. 创建namespace
```
kubectl create ns zookeeper
```
### 2. 创建zookeeper storageClass
```
kubectl apply -f ./sc.yaml;
```

### 3. 修改values.yaml
values.yaml常用参数说明
|参数名   | 参数值|  参数说明    |
|  ----  | ----  | --- |
|auth.client.enabled| true |是否启用ZooKeeper客户端-服务器认证，使用SASL/Digest-MD5协议 |
|replicaCount| 3 |实例数量|
| auth.client.clientUser| kafkaUser| ZooKeeper客户端认证的用户名|
| auth.client.clientPassword| openIMExamplePwd| ZooKeeper客户端认证的密码 |
| auth.client.serverUsers | kafkaUser| ZooKeeper服务器用户时使用的用户名 |
| auth.client.serverPasswords | openIMExamplePwd|ZooKeeper服务器用户时使用的密码 |
| global.password| openIMExamplePwd |zookeeper密码 |
| global.storageClass| zookeeper-data-sc |存储类名，需要和sc.yaml中storageClass保持一致|


### 3. 安装zookeeper集群
安装zookeeper集群
```
helm install zookeeper-cluster -f values.yaml bitnami/zookeeper -n zookeeper
```
卸载zookeeper集群
```
helm delete zookeeper-cluster -n zookeeper
```
通过values.yaml更新zookeeper集群
```
helm upgrade zookeeper-cluster  bitnami/zookeeper -f values.yaml -n zookeeper
```