# nfs external provisioner 部署文档
### helm安装
nfs external provisioner可以自动为pvc申请pv
add repo
```
helm repo add nfs-subdir-external-provisioner https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner/

helm repo update
```

helm pull provisioner
```
helm pull nfs-subdir-external-provisioner/nfs-subdir-external-provisioner;
tar -zxvf nfs-subdir-external-provisioner-4.0.18.tgz;
cd nfs-subdir-external-provisioner;
```

进入目录, 修改values.yaml, 仓库修改为阿里云镜像
```
repository: registry.cn-hangzhou.aliyuncs.com/lzf-k8s/k8s-nfs-storage
tag: 1.0.0
```

helm install 
```
helm install nfs-subdir-external-provisioner nfs-subdir-external-provisioner/nfs-subdir-external-provisioner \
    --set nfs.server=192.168.1.243 \
    --set nfs.path=/k8s/storage/nfs -f values.yaml 
```

查看provisioner
```
kubectl get pods
```

### helm卸载
```
helm delete nfs-subdir-external-provisioner
```