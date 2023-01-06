#!/bin/sh

kubectl get secret argocd-secret -n devtroncd -o jsonpath="{.data.tls\.crt}" | base64 -d | openssl x509 -enddate -noout
kubectl patch secret argocd-secret -n devtroncd --type=json -p='[{"op": "remove", "path": "/data/tls.crt"},{"op": "remove", "path": "/data/tls.key"}]'
sleep 4
kubectl delete pods -n devtroncd -l app.kubernetes.io/name=argocd-server
sleep 15
kubectl delete pods -n devtroncd -l component=devtron
kubectl get secret argocd-secret -n devtroncd -o jsonpath="{.data.tls\.crt}" | base64 -d | openssl x509 -enddate -noout
