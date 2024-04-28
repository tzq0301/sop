# Kubernetes

```bash
alias k='kubectl'
```

```bash
# po     <=> pods
# no     <=> nodes
# deploy <=> deployments
# svc    <=> services
# rs     <=> replicasets

# get 列出资源
kubectl get pods
kubectl get nodes
kubectl get deployments
kubectl get services
kubectl get replicasets

kubectl get services    $SERVICE_NAME
kubectl get deployments $DEPLOYMENT_NAME

kubectl get pods -o wide  # 更多的列（更详细的信息）

# describe 显示有关资源的详细信息
# describe 的输出设计为人类可读的信息，而不是脚本化的信息
kubectl describe pods
kubectl describe nodes
kubectl describe deployments

# logs 打印 Pod 中容器的日志
kubectl logs $POD_NAME

# exec 在 Pod 中的容器上执行命令
kubectl exec     $POD_NAME  -- env   # 列出 Pod 的容器中的环境变量
kubectl exec -it $POD_NAME  -- bash  # 在 Pod 的容器中启动一个 bash 会话

# Pod 运行在隔离的、私有的网络中，因此我们需要 proxy 访问它们，这样才能进行调试和交互
kubectl proxy

kubectl label  pods     $POD_NAME $LABEL=$LABEL_VALUE
kubectl get    pods     -l        $LABEL=$LABEL_VALUE
kubectl get    services -l        $LABEL=$LABEL_VALUE
kubectl delete service  -l        $LABEL=$LABEL_VALUE

# 扩缩容
kubectl scale deployments/$DEPLOYMENT_NAME --replicas=$NUM

# 更新应用程序的镜像版本，并启动滚动更新
kubectl set image deployments/$DEPLOYMENT_NAME $DEPLOYMENT_NAME=$NEW_IMAGE
# 通过运行 rollout status 来确认此次更新
kubectl rollout status deployments/$DEPLOYMENT_NAME
# 回滚 Deployment 到上一个工作的版本
kubectl rollout undo   deployments/$DEPLOYMENT_NAME
```