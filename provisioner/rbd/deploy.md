# rbd-provisioner 部署文档

## 安装rbd-provisioner
根据自己需要，修改rbd-provisioner的namespace
```
git clone https://github.com/kubernetes-incubator/external-storage.git;
cd external-storage/ceph/rbd/deploy;
NAMESPACE=kube-system;
sed -r -i "s/namespace: [^ ]+/namespace: $NAMESPACE/g" ./rbac/clusterrolebinding.yaml ./rbac/rolebinding.yaml;
kubectl -n $NAMESPACE apply -f ./rbac
```

## 验证
```
kubectl get deployment -n kube-system
```

