# mysql(1主N从)helm charts部署文档
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
#### 1. values.yaml常用参数说明
|参数名   | 参数值|  参数说明    |
|  ----  | ----  | --- |
| architecture| replication |主从复制模式|
| auth.rootPassword| openIMExamplePwd  |mysql密码， 用户为root用户，可不填 |
| global.storageClass| mysql-data-sc |存储类名，需要和sc.yaml中storageClass保持一致|
| secondary.replicaCount	|1 |从节点数量 |
| affinity | 示例如下| 亲和性 |

#### 2. affinity 配置
pod反亲和性，保证mysql的pod不会被调度到同一个node上运行
```
podAntiAffinity:
  requiredDuringSchedulingIgnoredDuringExecution:
    - topologyKey: kubernetes.io/hostname
      labelSelector:
        matchExpressions: 
          - key: mysql
            operator: In 
            values: 
            - "true"
```

pod反亲和性，尽量保证mysql的pod不会被调度到同一个node上运行，如果无法满足这个规则，也会将mysql调度到同一个node
```
podAntiAffinity:
  preferredDuringSchedulingIgnoredDuringExecution:
  - weight: 100
    podAffinityTerm:
      labelSelector:
        matchExpressions:
        - key: mysql
          operator: In
          values:
          - "true"
      topologyKey: kubernetes.io/hostname
```

### 3. 安装mysql集群
安装mysql集群
```
helm install mysql-cluster -f values.yaml bitnami/mysql -n mysql
```

卸载mysql集群
```
helm delete mysql-cluster  -n mysql
```

通过values.yaml更新mysql集群
```
helm upgrade mysql-cluster  bitnami/mysql -f values.yaml -n mysql
```