azloc="uksouth"
rgname="jupyterhubaks"
vnet="jh-vnet"
subnet_name="jhsubnet"

jhspname="jupyterhub-sp"
jhclustername="jh1"

helm upgrade --cleanup-on-fail \
  --install jh1-1 jupyterhub/jupyterhub \
  --namespace jh-k8s-namespace \
  --create-namespace \
  --version=2.0.0 \
  --values config.yaml
  