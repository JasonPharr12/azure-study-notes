# Project 4 - Infrastructure as Code with Bicep
## Objective
Automate the deployment of Azure cloud infrastructure using Microsoft Bicep, demonstrating that entire environments can be deployed consistently, repeatedly, and without human error in minutes rather than hours.
## Problem Statement
Manually deploying cloud infrastructure through the Azure portal is time consuming, error prone, and not repeatable. Rebuilding the environments from Projects 2 and 3 manually would take several hours and introduces the risk of misconfiguration at every step. In production environments infrastructure must be deployed consistently, repeatedly, and without human error. Infrastructure as Code solves this by defining the entire environment in code — enabling deployment in minutes, eliminating manual configuration errors, and ensuring every environment is identical to the last.
## Requirements

Repeatability: Bicep code must deploy identical infrastructure on every execution — same resource names, IP address ranges, region, configuration settings, and resource versions. No two deployments should produce different results.
Speed: Full infrastructure deployment must complete within minutes compared to several hours of manual portal deployment.
Safety: All Bicep code must be validated through a what-if dry run before execution in any real environment confirming planned changes before any resources are created modified or deleted.

## Architecture Components
### Azure Resources Deployed

Resource Group: RG-Project-04
Virtual Network: VNet-Project-04 (10.0.0.0/16)
Subnet-Public: 10.0.0.0/24
Subnet-Private: 10.0.1.0/24
NSG-Public: HTTP and HTTPS rules
NSG-Private: Load Balancer only rule
Public IP: PIP-Project-04
Azure Load Balancer: LB-Project-04 with health probe
Virtual Machine Scale Set: VMSS-Project-04 — Minimum 2 instances Maximum 10 instances
Azure Monitor: CPU metrics and scaling alerts

### Code Files

main.bicep — master orchestration file
network.bicep — Virtual Network and subnet definitions
nsg.bicep — Network Security Group rules
loadbalancer.bicep — Load Balancer and health probe
vmss.bicep — Virtual Machine Scale Set and scaling rules
parameters.json — environment specific values

### Tools

Azure CLI — deployment execution
Visual Studio Code — code editor
Bicep VS Code Extension — syntax support and error checking
GitHub — version control and code storage

## Design Rationale
Bicep over Manual Portal Configuration: Microsoft Bicep provides a structured, repeatable, and version controlled method for defining Azure infrastructure. Unlike manual portal deployments which rely on human memory and manual input, Bicep code explicitly defines every resource, every configuration, and every dependency. This eliminates configuration drift, enables peer review of infrastructure changes, and produces error free deployments that are identical every time the code runs.
GitHub for Code Storage: Storing Bicep code in GitHub provides four critical capabilities. Version control maintains a complete history of every change. Collaboration enables multiple engineers to review and contribute. Disaster recovery ensures the infrastructure definition survives even if a local machine is lost. Automated deployment enables code to be triggered through a pipeline without manual intervention — the foundation of DevSecOps practice.
Redeploying Projects 2 and 3 Infrastructure: Using Bicep to redeploy known infrastructure demonstrates that the code produces predictable and consistent results against a validated baseline. Since the manual deployment is already documented and tested the Bicep output can be validated directly against it — confirming the code produces exactly what it should.
## Risk Assessment
Wrong Environment Risk: Bicep does not validate whether the target resource group is the intended environment. Running code against the wrong resource group could modify or destroy production infrastructure silently. Mitigation: The what-if command must be executed before every deployment. Resource group names follow strict environment naming conventions — RG-Dev, RG-Staging, RG-Prod — making accidental targeting immediately obvious.
Partial Deployment Risk: Azure does not automatically roll back failed deployments by default. If a deployment fails midway the environment is left in a partial and potentially insecure state. Mitigation: Deployments validated with what-if before execution. Recovery procedures documented for each failure scenario. Complete deployments confirmed by verifying all expected resources exist after each run.
Concurrent Modification Risk: Two engineers modifying the same Bicep file simultaneously and deploying independently risks the second deployment overwriting the first without warning. Mitigation: All Bicep code changes must go through GitHub pull requests before deployment. Branch protection rules prevent unreviewed code from reaching the main branch.
## Success Criteria

Reliability: Bicep code successfully deploys complete and identical infrastructure on every execution with no partial deployments. Deployed infrastructure matches Projects 2 and 3 documentation exactly.
Security: All deployed resources verified against security requirements after every deployment. NSG rules confirm instances accept traffic only from Load Balancer. Security configuration identical across every deployment.
Performance Efficiency: Deployed compute resources appropriately sized for intended workload. Virtual Machine Scale Set responds to demand changes within defined thresholds confirming scaling configuration functions correctly.
Cost Optimization: Deployment time reduced from several hours to under 10 minutes. No idle or unnecessary resources exist after deployment. What-if command used before every deployment to prevent accidental resource creation.
Operational Excellence: Every deployment executed from version controlled Bicep code in GitHub. All deployments logged with engineer name, date, target environment, and outcome. Entire environment destroyed and redeployed from code in under 10 minutes demonstrating no manual dependencies.

## Architecture Diagram
See Project-4-IaC-Architecture.png in this folder
## Status
Design Complete - COMPLETE
**Build Progress**

Development environment configured — Azure CLI, VS Code, Bicep CLI
main.bicep — master orchestration file created
network.bicep — VNet and subnet definitions
nsg.bicep — NSG security rules
loadbalancer.bicep — Load Balancer with health probe
parameters.json — deployment parameters
What-if validation executed successfully before deployment
Full infrastructure deployed with single command
Infrastructure deleted and rebuilt from code in under 5 minutes
All Bicep code pushed to GitHub for version control
