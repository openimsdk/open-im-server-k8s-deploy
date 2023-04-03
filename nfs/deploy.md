# nfs相关文档
###
```
helm install nfs-subdir-external-provisioner nfs-subdir-external-provisioner/nfs-subdir-external-provisioner \
    --set nfs.server=192.168.1.234 \
    --set nfs.path=/k8s/storage/nfs
```

```
helm delete nfs-subdir-external-provisioner
```