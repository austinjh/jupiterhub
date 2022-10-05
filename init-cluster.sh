azloc="uksouth"
rgname="jupyterhubaks"
vnet="jh-vnet"
subnet_name"jhsubnet"

jhspname="jupyterhub-sp"



VNET_ID=$(az network vnet show \
   --resource-group $rgname \
   --name $vnet \
   --query id \
   --output tsv)

SUBNET_ID=$(az network vnet subnet show \
   --resource-group $rgname \
   --vnet-name $vnet \
   --name $subnet_name \
   --query id \
   --output tsv)

SP_PASSWD=$(az ad sp create-for-rbac \
   --name $jhspname \
   --role Contributor \
   --scopes $VNET_ID \
   --query password \
   --output tsv)
SP_ID=$(az ad app list \
   --filter "displayname eq 'jhspname'" \
   --query [0].appId \
   --output tsv)

az aks create \
   --name <CLUSTER-NAME> \
   --resource-group <RESOURCE-GROUP-NAME> \
   --ssh-key-value ssh-key-<CLUSTER-NAME>.pub \
   --node-count 3 \
   --node-vm-size Standard_D2s_v3 \
   --service-principal $SP_ID \
   --client-secret $SP_PASSWD \
   --dns-service-ip 10.0.0.10 \
   --docker-bridge-address 172.17.0.1/16 \
   --network-plugin azure \
   --network-policy azure \
   --service-cidr 10.0.0.0/16 \
   --vnet-subnet-id $SUBNET_ID \
   --output table