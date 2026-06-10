# Project 2 - Highly Available Web Tier
## Objective
Design and deploy a production grade highly available web tier in Azure demonstrating fault tolerance, automatic failover, and defense in depth security across multiple availability zones.
## Problem Statement
A single virtual machine represents a single point of failure. If the VM experiences hardware failure, software failure, or requires maintenance, the application becomes unavailable. High availability architecture eliminates this risk by ensuring that if one component fails, redundant components automatically absorb the workload with no interruption to end users or business operations.
## Requirements

Availability: Minimum 99.9% uptime across all components
Recovery: Automatic traffic rerouting within 15 seconds of VM failure
Security: No direct internet access to VMs. All traffic must pass through the Load Balancer only

## Architecture Components

Resource Group: RG-Project-02
Virtual Network: VNet-Project-02 (10.0.0.0/16)
Subnet-Public: 10.0.0.0/24 (Availability Zone 1)
Subnet-Private: 10.0.1.0/24 (Availability Zone 2)
VM-1: Web server in Availability Zone 1
VM-2: Web server in Availability Zone 2
Azure Load Balancer: Public facing traffic distribution
Health Probes: TCP Port 80 checking every 5 seconds
NSG-Public: Allow Load Balancer traffic only, deny direct internet
NSG-Private: Allow Load Balancer traffic only, deny direct internet
Azure Monitor: VM health alerting and diagnostics

## Design Rationale
Availability Zone Distribution: VMs are deployed across two separate availability zones representing independent physical locations with separate power, cooling, and networking. In the event of a natural disaster or hardware failure affecting one zone the application continues running in the second zone.
Automated Load Balancing: Azure Load Balancer is deployed in front of all VMs rather than relying on manual failover. Automated health probes detect VM failure within seconds and immediately reroute traffic to healthy instances meeting our 15 second recovery requirement.
Defense in Depth Security: VMs accept traffic exclusively from the Azure Load Balancer. This eliminates the attack surface presented by publicly exposed VMs and ensures all traffic passes through a controlled entry point.
## Risk Assessment
Misconfiguration Risk: Incorrect load balancer routing rules or improperly configured health probe parameters could cause traffic to route to unhealthy VMs or drop entirely.
Mitigation: All configurations will be explicitly tested before deployment and validated against Azure best practices.
## Success Criteria

Reliability: Traffic automatically reroutes to healthy VM within 15 seconds of simulated failure
Performance: Load balancer distributes traffic evenly across both VMs
Security: Direct VM access from internet confirmed blocked
Cost: Architecture cost documented and optimized
Operational Excellence: Azure Monitor alerts configured to notify of VM failures within 60 seconds

## Architecture Diagram
See Project-2-Architecture-Diagram.png in this folder
## Status
Design Complete - Build In Progress
