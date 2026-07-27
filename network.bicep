// network.bicep
// Deploys Virtual Network with public and private subnets

var location = 'eastus'
var projectName = 'Project04'

resource vnet 'Microsoft.Network/virtualNetworks@2023-04-01' = {
  name: 'VNet-${projectName}'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'Subnet-Public'
        properties: {
          addressPrefix: '10.0.0.0/24'
        }
      }
      {
        name: 'Subnet-Private'
        properties: {
          addressPrefix: '10.0.1.0/24'
        }
      }
    ]
  }
}