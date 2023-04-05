helm install kafka-cluster -f values.yaml bitnami/kafka -n kafka
helm uninstall kafka-cluster -n kafka