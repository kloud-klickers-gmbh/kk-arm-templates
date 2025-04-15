# Azure Landing Zone – Strukturübersicht

```
Microsoft Tenant
└── Azure Subscription
    ├── Subscription-Einstellungen
    │   ├── Microsoft Defender for Cloud (Plan 1)
    │   │   ├── Virtual Machines: Standard
    │   │   └── Storage Accounts: Standard (Defender for Storage V2)
    │
    └── Azure Landing Zone
        ├── Ressourcengruppen
        │   ├── {prefix}-vnet-rg
        │   │   ├── Virtual Network (VNet)
        │   │   ├── Subnet LAN / WAN / DMZ
        │   │   └── Network Security Group (NSG) mit RDP-Regel
        │   │
        │   ├── {prefix}-jumphost-rg
        │   │   ├── Virtual Machine (Windows Server 2022 B2s)
        │   │   ├── Public IP (statisch, mit DNS-Name)
        │   │   └── Network Interface (verbunden mit LAN-Subnetz)
        │   │
        │   ├── {prefix}-log-operations-rg
        │   │   ├── Log Analytics Workspace
        │   │   ├── Data Collection Rule: VM
        │   │   └── Data Collection Rule: AVD
        │   │
        │   ├── {prefix}-update-rg
        │   │   ├── Maintenance Configuration (Patch-Zeitfenster)
        │   │   └── Automatisches Maintenance Assignment für alle VMs der Subscription
        │   │
        │   ├── {prefix}-managed-identities-rg
        │   │   ├── User Assigned Identity (VM)
        │   │   ├── User Assigned Identity (Policies)
        │   │   └── Role Assignments (z. B. Reader, Contributor etc.)
        │   │
        │   └── {prefix}-backup-rg
        │       ├── Recovery Services Vault (LRS)
        │       ├── Recovery Services Vault (GRS)
        │       └── Backup Policies (VM, AVD, Files, Profile)
        │
        └── Azure Policies
            ├── Microsoft Cloud Security
            ├── Regelmäßige Überprüfung auf fehlende Systemupdates bei Windows-VMs aktivieren
            ├── Regelmäßige Überprüfung auf fehlende Systemupdates bei Linux-VMs aktivieren
            ├── Wiederkehrende Updates mit dem Azure Update Manager planen
            ├── Voraussetzungen für geplante Updates bei Azure-VMs einrichten
            ├── Azure Monitor mit dem Azure Monitoring Agent (AMA) für VMs aktivieren
            ├── Protokollierung für Hostpools (AVD) an Log Analytics aktivieren
            ├── Protokollierung für Workspaces (AVD) an Log Analytics aktivieren
            └── Azure Defender for Servers für Ressourcen mit bestimmtem Tag deaktivieren
```