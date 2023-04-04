# nfs external provisioner 部署文档
### helm安装

add repo
```
helm repo add nfs-subdir-external-provisioner https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner/

helm repo update
```

helm pull 
```
 helm pull nfs-subdir-external-provisioner/nfs-subdir-external-provisioner
```

修改values.yaml, 仓库修改为阿里云镜像
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

### helm卸载
```
helm delete nfs-subdir-external-provisioner
```