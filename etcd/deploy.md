# etcd集群(3实例)helm charts部署文档
## 部署步骤
### 1. 创建namespace
```
kubectl create namespace etcd
```
### 2. 创建etcd storageClass
```
    kubectl apply -f ./sc.yaml;
```

### 3. 修改values.yaml
values.yaml常用参数说明
|参数名   | 参数值|  参数说明    |
|  ----  | ----  | --- |
| replicaCount| 3 | etcd实例数量|
| auth.rootPassword| openIMExamplePwd |etcd密码， 用户为root用户，可不填 |
| global.storageClass| etcd-data-sc| 存储类名，需要和sc.yaml中storageClass保持一致|

节点亲和性, 保证三台服务器上不会出现一台服务器部署两个etcd实例的情况
```
podAntiAffinity:
    requiredDuringSchedulingIgnoredDuringExecution:
      nodeSelectorTerms:
      - matchExpressions:
        - key: etcd
          operator: In
          values:
          - true
```

### 3. 安装etcd集群
安装etcd集群
```
helm install etcd-cluster -f values.yaml bitnami/etcd -n etcd
```

卸载etcd集群
```
helm delete etcd-cluster  -n etcd
```


通过values.yaml更新etcd集群
```
helm upgrade etcd-cluster bitnami/etcd -f values.yaml -n etcd
```