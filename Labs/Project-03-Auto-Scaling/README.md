# Project 3 - Auto Scaling Infrastructure
## Objective

Design and deploy an auto scaling cloud infrastructure in Azure that automatically adjusts compute resources in real time based on demand, demonstrating scalability, cost optimization, and operational excellence.
## Problem Statement

Static infrastructure cannot respond to fluctuating demand. During traffic spikes a fixed number of VMs becomes overwhelmed causing application slowdowns and outages. During low traffic periods those same VMs sit idle consuming cost unnecessarily. Manual scaling introduces human response time and human error as dependencies during critical moments. Auto scaling eliminates these problems by automatically adjusting compute resources in real time based on actual demand.
## Requirements

Scaling: Add instances when average CPU exceeds 75% for 5 minutes. Remove instances when CPU drops below 25% for 10 minutes. Minimum 2 instances. Maximum 10 instances.
Cost: Instance count bounded between minimum and maximum to prevent unbounded resource growth. Scale in policies aggressively remove unnecessary instances during low demand.
Monitoring: Azure Monitor collects CPU memory and network metrics in real time. Automated alerts notify engineers of scaling events and threshold breaches.

## Architecture Components

Resource Group: RG-Project-03
Virtual Network: VNet-Project-03 (10.0.0.0/16)
Subnet-Public: 10.0.0.0/24 — Load Balancer frontend
Subnet-Private: 10.0.1.0/24 — Scale Set instances
NSG-ScaleSet: Allow Load Balancer traffic only, deny direct internet
Public IP: PIP-Project-03
Azure Load Balancer: LB-Project-03
Virtual Machine Scale Set: VMSS-Project-03
Minimum instances: 2
Maximum instances: 10
Scale out trigger: CPU greater than 75% for 5 minutes
Scale in trigger: CPU less than 25% for 10 minutes
Azure Monitor: CPU metrics, scaling alerts, dashboard
Azure Cost Management: Spending alerts and instance cost tracking

## Design Rationale

Virtual Machine Scale Sets: Responds to demand in real time without human intervention. Manual VM provisioning during a traffic spike requires an engineer to detect the problem, decide, and execute — taking minutes to hours while users experience degraded performance. A Scale Set detects the scaling condition automatically and deploys additional instances within minutes.
Minimum Instance Count: A minimum of 2 instances are maintained at all times. Scaling to zero would cause complete application unavailability. Maintaining 2 instances preserves high availability — if one instance fails the second continues serving traffic while the Scale Set provisions a replacement.
CPU Utilization as Scaling Metric: CPU utilization directly reflects how hard existing instances are working to handle current demand. High CPU indicates instances are approaching capacity limits. Low CPU indicates underutilization. This ensures scaling decisions are based on actual compute stress maintaining optimal performance while controlling cost.
## Risk Assessment

Threshold Misconfiguration Risk: Incorrectly configured thresholds cause premature scaling that wastes cost or delayed scaling that causes degraded performance. Mitigation: Thresholds validated through load testing before production deployment.
Wrong Metric Risk: CPU utilization may not accurately reflect application stress for all workload types. A database-heavy application may slow due to memory or disk bottlenecks while CPU remains low — meaning scaling never triggers. Mitigation: Azure Monitor tracks CPU, memory, disk, and network metrics simultaneously.
Aggressive Scale In Risk: Removing instances too quickly during a brief traffic dip leaves infrastructure undersized when traffic immediately spikes again. Mitigation: Scale in cooldown periods of 10 minutes prevent rapid instance removal and thrashing between scale out and scale in events.
## Success Criteria

Reliability: Architecture tolerates instance failure without manual intervention. Scale Set automatically provisions replacements.
Security: All instances in Subnet-Private. Traffic accepted only from Load Balancer. Direct internet access blocked and logged.
Performance Efficiency: System automatically adds instances at 75% CPU and removes at 25% CPU. Load testing validates acceptable response times under peak demand.
Cost Optimization: Instance count never exceeds maximum of 10. Scale in policies reduce to minimum of 2 during low traffic. Hourly spend correlates directly with actual demand.
Operational Excellence: All scaling events logged in Azure Monitor. Alerts notify engineers when maximum capacity is reached or thresholds are sustained.

## Architecture Diagram

See Project-3-Architecture-Diagram.png in this folder
## Status

Design Complete - Build Pending VM Quota Approval
