azloc="uksouth"
rgname="jupyterhubaks"
vnet="jh-vnet"
subnet_name="jhsubnet"

jhspname="jupyterhub-sp"
jhclustername="jh1"

az aks get-credentials \
   --name $jhclustername \
   --resource-group $rgname \
   --output tableku