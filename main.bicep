// Project 4 - Infrastructure as Code with Azure Bicep
// Author: Jason Pharr
// Description: Deploys secure cloud infrastructure including VNet, NSGs, and Load Balancer

// Parameters
param location string = 'eastus'
param projectName string = 'Project04'

// Deploy Network
module network 'network.bicep' = {
  name: 'networkDeployment'
}

// Deploy NSG
module nsg 'nsg.bicep' = {
  name: 'nsgDeployment'
}

// Deploy Load Balancer
module loadbalancer 'loadbalancer.bicep' = {
  name: 'loadbalancerDeployment'
}