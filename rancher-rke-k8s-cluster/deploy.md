# rancher RKE部署k8s集群部署文档
## 部署步骤
该文档以3台服务器为例
### 1. 在每台服务器上添加rke执行操作的用户
用户需要有使用docker的权限
```
useradd rke;
sudo usermod -aG docker rke;
```
这个地方注意本机的公钥需要上传到目标服务器， 否则rke允许的时候会报WARN,导致失败
```
ssh-keygen;
ssh-copy-id -i ~/.ssh/id_rsa.pub 192.168.1.1;
```

### 2. 下载rancher rke二进制文件并安装
#### 1. 下载rke
rke二进制文件下载：https://github.com/rancher/rke/releases
```
wget https://github.com/rancher/rke/releases/download/v1.4.3/rke_linux-amd64;
mv ./rke_linux-amd64 ./rke;
```
#### 2. 安装k8s集群
```
./rke up --config cluster.yaml;
```
集群构建成功后控制台会打印 Finished building Kubernetes cluster successfully 
保存cluster.rkestate，kube_config_cluster.yaml作为k8s管理集群的凭据。

### 3. 安装kubectl
#### 1. 下载kubectl
kubectl 版本和集群版本之间的差异必须在一个小版本号内
```
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl";
curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
```
校验文件
```
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
```
通过时输出为
```
kubectl: OK
```
#### 2.安装kubectl
```
install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl;
```
#### 3.验证
```
kubectl version --client
```

#### 3. 配置kubectl
```
mkdir ~/.kube
mv ./kube_config_cluster.yaml ~/.kube/config
```

#### 4. 验证
查看所有节点
```
kubectl get node
```

### 4. helm chart安装
#### 1. 安装helm
```
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null;
sudo apt-get install apt-transport-https --yes;
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list;
sudo apt-get update;
sudo apt-get install helm;
```
#### 2. 初始化
```
helm repo add bitnami https://charts.bitnami.com/bitnami;
helm repo update;
```

### 5. docker安装单机rancher
```
sudo docker run -d --restart=unless-stopped -p 80:80 -p 443:443 rancher/rancher
```

## 常见问题
清理脚本: clear_env.sh，worder和master执行，
删除cluster.rkestate，kube_config_cluster.yaml缓存，
ssh密钥配置问题。