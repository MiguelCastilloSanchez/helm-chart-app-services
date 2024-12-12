#!/bin/bash
kubectl create namespace app-test

helm install my-mongodb-auth-service bitnami/mongodb -f ./internal-services/mongodb-values-auth-service.yaml -n app-test
helm install my-mongodb-users-service bitnami/mongodb -f ./internal-services/mongodb-values-users-service.yaml -n app-test
helm install my-mongodb-posts-service bitnami/mongodb -f ./internal-services/mongodb-values-posts-service.yaml -n app-test

helm install my-rabbitmq bitnami/rabbitmq -f ./internal-services/rabbitmq-values.yaml -n app-test

helm install my-redis bitnami/redis -f ./internal-services/redis-values.yaml -n app-test
