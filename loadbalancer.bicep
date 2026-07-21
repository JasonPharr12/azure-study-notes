// loadbalancer.bicep
// Deploys Public IP and Load Balancer with health probe and load balancing rule

var location = 'eastus'
var projectName = 'Project04'

// Public IP Address
resource publicIP 'Microsoft.Network/publicIPAddresses@2023-04-01' = {
  name: 'PIP-${projectName}'
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}

// Load Balancer
resource loadBalancer 'Microsoft.Network/loadBalancers@2023-04-01' = {
  name: 'LB-${projectName}'
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    frontendIPConfigurations: [
      {
        name: 'Frontend-IP'
        properties: {
          publicIPAddress: {
            id: publicIP.id
          }
        }
      }
    ]
    backendAddressPools: [
      {
        name: 'Backend-Pool'
      }
    ]
    probes: [
      {
        name: 'Health-Probe'
        properties: {
          protocol: 'Tcp'
          port: 80
          intervalInSeconds: 5
          numberOfProbes: 2
        }
      }
    ]
    loadBalancingRules: [
      {
        name: 'LB-Rule-HTTP'
        properties: {
          frontendIPConfiguration: {
            id: resourceId('Microsoft.Network/loadBalancers/frontendIPConfigurations', 'LB-${projectName}', 'Frontend-IP')
          }
          backendAddressPool: {
            id: resourceId('Microsoft.Network/loadBalancers/backendAddressPools', 'LB-${projectName}', 'Backend-Pool')
          }
          probe: {
            id: resourceId('Microsoft.Network/loadBalancers/probes', 'LB-${projectName}', 'Health-Probe')
          }
          protocol: 'Tcp'
          frontendPort: 80
          backendPort: 80
          idleTimeoutInMinutes: 4
        }
      }
    ]
  }
}