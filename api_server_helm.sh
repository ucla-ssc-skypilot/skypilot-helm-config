sudo apt install curl
sudo curl -fsSL https://tailscale.com/install.sh | sh
sudo tailscale up

NAMESPACE=skypilot
RELEASE_NAME=skypilot
WEB_USERNAME=skypilot

kubectl create secret generic apiserver-ssh-key \
  --namespace skypilot \
  --from-file=id_rsa=/root/id_rsa \
	--from-file=other_id_rsa=/root/id_rsa.pub

helm upgrade --install skypilot skypilot/skypilot-nightly --devel \
  --namespace skypilot \
  --create-namespace \
  --set auth.oauth.enabled=true \
  --set auth.oauth.oidc-issuer-url=https://accounts.google.com \
  --set auth.oauth.client-id=xxx.apps.googleusercontent.com \
  --set auth.oauth.client-secret=xxx \
  --set auth.oauth.email-domain=g.ucla.edu \
  --set ingress-nginx.controller.service.type=NodePort \
  --set ingress-nginx.controller.service.nodePorts.http=30050 \
  --set ingress-nginx.controller.service.nodePorts.https=30051 \
  --set-file apiService.sshNodePools=/xxx/ssh_node_pools.yaml \
  --set apiService.sshKeySecret=apiserver-ssh-key
  --set apiService.metrics.enabled=true \
  --set prometheus.enabled=true \
  --set grafana.enabled=true

