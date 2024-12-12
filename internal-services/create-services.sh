#!/bin/bash
kubectl create namespace app-test

helm install my-mongodb-auth-service bitnami/mongodb -f mongodb-values-auth-service.yaml -n app-test
helm install my-mongodb-users-service bitnami/mongodb -f mongodb-values-users-service.yaml -n app-test
helm install my-mongodb-posts-service bitnami/mongodb -f mongodb-values-posts-service.yaml -n app-test

helm install my-rabbitmq bitnami/rabbitmq -f rabbitmq-values.yaml -n app-test

helm install my-redis bitnami/redis -f redis-values.yaml -n app-test
