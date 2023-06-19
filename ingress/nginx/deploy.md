
# ingress nginx controller部署文档
## 部署步骤
### 1. 创建namespace
```
kubectl create ns nginx
```
### 2. 创建kafka storageClass
```
  kubectl apply -f ./sc.yaml;
```

### 3. 修改values.yaml