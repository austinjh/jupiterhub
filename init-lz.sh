azloc="uksouth"
rgname="jupyterhubaks"
vnet="jh-vnet"
subnet_name"jhsubnet"


#az login
#az account list --refresh --output table
#az account set --subscription 89c2a69c-4aa4-410f-af44-f86f6324c4bc

az group create \
   --name=$rgname \
   --location=$azloc \
   --output table

az network vnet create \
   --resource-group $rgname \
   --name $vnet \
   --address-prefixes 10.0.0.0/16 \
   --subnet-name $subnet_name \
   --subnet-prefix 10.240.0.0/24

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

