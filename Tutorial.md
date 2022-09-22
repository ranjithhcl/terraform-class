### Begin the Azure journey

#### Notes for myself

Udemy:
microsoft-azure-from-zero-to-hero-the-complete-guide

Infrastructure as Code
Policy as Code
Configuration as Code
Deployment as Code
Documentation as Code

![](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/enterprise-scale/media/az-scopes-billing.png)

https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-area/azure-billing-ad-tenant

https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/considerations/automation#platform-automation-design-recommendation

Link:
<https://portal.azure.com>

1. Subscription Free Trail/Microsoft/Pay as you go

`az login`
`az account list`
`az group list`

Mgmt Groups -> Subscriptions -> RG -> Resources

SLA calculate:
<https://uptime.is/>

### Virtual Machines

1. Defualt VM with new RG and available subscriptions.

2. Optimised VM with Availability set/Availabity Zone

    - Fault domain/Update domain (2/3)
    - Availablity Zone (Different DS)
    - HDD to SSD (Hight throughput)

3. ARM template (Download or upload and deploy)

4. Delete VM and assosiated resource, last RG

5. Scale Set

    - `az provider show --namespace microsoft.insights -o table`

6. Metadata service

    - Provide event details if VM get deleted or shutdown by Azure service

7. App service (Build and deploy code to the App service)

    - Use the Build service to build the code and deploy in app service.
    - NSG (All inbound ports are allowed)
    - Access restrictions (not in free Tier) restrict only IP for APP service

8. AKS

    - Kube service
    - Add nodes and Deploy a sample application via Container registry.
    - Minimal cluster, dev/test
    - Quota for VM in the region
    - `az provider show --namespace Microsoft.ContainerRegistry -o table`

9. Azure Functions

    - Trigger and Binding (Timer and Event)
    - Cold start (Specical allocation and run the functions)
    - Hosting plans
        - Consumption plan ( <= 1.5G RAM, Cold start)
        - Premium plan (1 pre warmed(2vcpus, 7GB))
        - Dedicated plan (no auto scale)
    - Durable Functions

    - Example:
        - `brew tap azure/functions && brew install azure-functions-core-tools@4`

10. Choose right compute type.
    - Function vs AKS vs App service vs VM's
    - Logic Apps, ACI , App service Container

### Networking

1. Vnets (same like VPC in AWS)

    - CIDR (classless inter domain routing )

    ```bash
    10.120.244.120/32 - Per IP (8bits.8bits.8bits.8bits)

    109.186.149.240/24 ---> Size = 2^(32-24) = 2^8 = 256
    ```

    - Subnets (Fontend/Backend)

    - NSG(mini firewall)

        - Add a service Tag as best practise

    - Network Peering (Vnet <-> Vnet2)

    - Network watcher

    - Secured Access (JIT, VPN, JumpBox, Bastion - Require portal access)

    - Service Endpoints (Route -> managed service) ( subnet is the source of traffic) - leagcy

    - Private Link (not free & On perm supported)

2. LoadBalancer

    - Standard vs Basic
    - Rules:

        - Frontend IP config
        - Backend Pools
        - Health Probes
        - Load Balancing Rules

    - Application GW (similar to ALB) [ Basics -> Frontends -> Backends -> configuration -> tags -> Review+create ]

        - Route based routing
        - WAF (firwall on request)
        - App service behind the Application GW

    - Application GW infront of AKS is not recommended ?

### DB Storage

1. Azure SQL DB (Manged, Security, backup)

    - Retention backup (7days)
    - Geo replication
    - Provisioned resource(pay highfront)
    - Serverless DB
    - Elastic Pool (multiple DB) - Cost effective
    - Pricing ? Managed vs Azure SQL(DTU/vCores)
      <WIP>

2. Azure Mysql

    - Backup (Basic - Fullbackup everyday, General purpose upto 4GB diff backup twice a day)
    - Pricing (Basic, GP, Memory Optimised)

3. Cosmos DB (TODO)

4. PostgreSQL (TODO)

5. Azure Storage Types (Blobs, Files, Queues, Tables)

    - Account -> Container -> Blobs
    - LRS (local Redundant storage), ZRS(Zone Redundant storage), GRS(Failover over geo, 3times of storage)
    - GZRS(3 zones and geo), RA-GRS(Read-Access-Geo), RA-GZRS
    - Hot(99.9%), Cool(99%) (atleast 30days), Archive (high access cost)

    Costing:

    - LRS/Hot/Capacity/Operation_cost
    - LRS/Cool/Capacity/Operation_cost
    - Blob access is anonymous with access tier. SAAS token to access.
    - Access to Blob can be modified, for set of IP
    -
