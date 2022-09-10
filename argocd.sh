#!/bin/sh

kubectl get secret argocd-secret -n devtroncd -o yaml > argocd-secret.yaml
crtline=$(sed -n '/\btls.crt:.*\b/=' argocd-secret.yaml)
sed -i "$crtline"d argocd-secret.yaml
keyline=$(sed -n '/\btls.key:.*\b/=' argocd-secret.yaml)
sed -i "$keyline"d argocd-secret.yaml
cat argocd-secret.yaml
kubectl apply -f argocd-secret.yaml
kubectl delete pods -n devtroncd -l app.kubernetes.io/name=argocd-server
sleep 15
kubectl delete pods -n devtroncd -l component=devtron
