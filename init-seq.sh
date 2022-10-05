azloc="uksouth"
rgname="jupiterhubaks"


az login
az account list --refresh --output table
#az account set --subscription <YOUR-CHOSEN-SUBSCRIPTION-NAME>

az group create \
   --name=$rgname \
   --location=$azloc \
   --output table

