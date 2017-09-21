# mcv-azure-arm-noc

This is based on the project found here https://github.com/Azure/azure-quickstart-templates/tree/master/active-directory-new-domain-ha-2-dc


## Active Directory 

This template will deploy 2 new VMs (along with a new VNet, Storage Account and Load Balancer) and create a new  AD forest and domain, each VM will be created as a DC for the new domain and will be placed in an availability set. Each VM will also have an RDP endpoint added with a public load balanced IP address.

