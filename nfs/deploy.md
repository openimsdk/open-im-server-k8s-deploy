# nfs相关文档
###
```
helm install stable/nfs-client-provisioner --set nfs.server=192.168.1.124 --set nfs.path=/k8s/storage/nfs
```