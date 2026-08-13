# Terraform Azure Resource Group

[![Terraform](https://img.shields.io/badge/Terraform-%3E%3D1.0-blue?style=flat&logo=terraform)](https://www.terraform.io/)
[![Azure](https://img.shields.io/badge/Azure-Cloud-blue?style=flat&logo=microsoft-azure)](https://azure.microsoft.com/)
[![License](https://img.shields.io/badge/License-MIT-green?style=flat)]()

## 📋 Project Overview

This repository demonstrates **Infrastructure as Code (IaC)** principles using **Terraform** to provision and manage **Azure Resource Groups**. It serves as a practical example of automating cloud infrastructure deployment on Microsoft Azure, showcasing best practices for version control, scalability, and reproducibility.

### Key Highlights:
- Automated Azure Resource Group provisioning using Terraform
- Multi-region and multi-environment support via variables
- Git-based workflow for infrastructure changes
- Production-ready configuration structure

---

## 🏗️ Architecture / Workflow

The deployment workflow follows a GitOps-inspired architecture:

```
Developer
   ↓
Git (local commit)
   ↓
GitHub (push)
   ↓
Terraform (init, plan, apply)
   ↓
Azure Resource Group (provisioned)
```

**Workflow Steps:**
1. **Developer** writes IaC code locally
2. **Git** tracks changes in version control
3. **GitHub** stores and manages code repository
4. **Terraform** validates, plans, and applies infrastructure changes
5. **Azure** provisions and manages resources

---

## 🛠️ Technologies Used

| Technology | Purpose |
|---|---|
| **Microsoft Azure** | Cloud infrastructure platform |
| **Terraform** | Infrastructure as Code (IaC) tool |
| **AzureRM Provider** | Terraform provider for Azure resources |
| **Git** | Version control system |
| **GitHub** | Remote repository hosting |
| **VS Code** | Code editor (recommended) |

---

## 📋 Prerequisites

Before getting started, ensure you have the following installed and configured:

- **Azure Subscription** - Active Azure account with appropriate permissions
- **Azure CLI** - Command-line tool for Azure management
- **Terraform** - Version 1.0 or higher
- **Git** - Version control tool
- **GitHub Account** - For repository management and collaboration

### Installation Commands:

```bash
# Install Azure CLI (macOS with Homebrew)
brew install azure-cli

# Install Terraform (macOS with Homebrew)
brew install terraform

# Install Git
brew install git
```

---

## 📁 Project Structure

```
GitTest/
├── main.tf                    # Main Terraform configuration (Resource Group definition)
├── provider.tf                # Azure provider and Terraform version requirements
├── variables.tf               # Variable definitions for input values
├── terraform.tfvars.example   # Example variables file (reference for users)
├── .gitignore                 # Git ignore rules for Terraform files
├── .terraform.lock.hcl        # Terraform provider lock file
└── README.md                  # This file
```

### File Descriptions:

- **main.tf** - Defines Azure Resource Group resources using `for_each` for flexibility
- **provider.tf** - Configures AzureRM provider with version constraints
- **variables.tf** - Declares input variables for subscription_id and resource_groups
- **terraform.tfvars.example** - Template file for users to create terraform.tfvars
- **.gitignore** - Prevents sensitive files from being committed
- **.terraform.lock.hcl** - Ensures consistent provider versions across teams

---

## 🔐 Azure Authentication

Terraform requires authentication with Azure. Use the Azure CLI to authenticate:

### Step 1: Login to Azure
```bash
az login
```
This command opens a browser to authenticate with your Azure account.

### Step 2: Verify Your Subscription
```bash
az account show
```
**Output Example:**
```json
{
  "environmentName": "AzureCloud",
  "id": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  "isDefault": true,
  "name": "My Subscription",
  "state": "Enabled",
  "tenantId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  "user": {
    "name": "user@example.com",
    "type": "user"
  }
}
```

### Step 3: Configure Subscription ID
Copy your subscription `id` and add it to your `terraform.tfvars` file:
```hcl
subscription_id = "your-subscription-id"
```

**⚠️ Security Warning:** Do NOT commit actual subscription IDs, secrets, credentials, or tokens to version control. Use `.gitignore` and environment-specific `.tfvars` files.

---

## 🚀 Terraform Commands

### Initialize Terraform
```bash
terraform init
```
Downloads required providers and initializes the working directory.

### Format Code
```bash
terraform fmt
```
Automatically formats Terraform files for consistency.

### Validate Configuration
```bash
terraform validate
```
Checks syntax and consistency of configuration files.

### Plan Infrastructure
```bash
terraform plan
```
Shows what infrastructure will be created, modified, or destroyed.

**Output Example:**
```
Terraform will perform the following actions:

  # azurerm_resource_group.RGrp["dev"] will be created
  + resource "azurerm_resource_group" "RGrp" {
      + id       = (known after apply)
      + location = "eastus"
      + name     = "dev-rg"
    }

Plan: 1 to add, 0 to change, 0 to destroy.
```

### Apply Infrastructure
```bash
terraform apply
```
Provisions the infrastructure in Azure based on the plan.

### Destroy Infrastructure
```bash
terraform destroy
```
Removes all resources managed by Terraform.

**⚠️ Caution:** This will delete all resources. Use with care in production environments.

---

## ⚙️ Configuration

### Variables

Input variables are defined in `variables.tf` and allow customization without modifying core Terraform code.

**Example `variables.tf`:**
```hcl
variable "subscription_id" {
  description = "The subscription ID to use for the resource group."
  type        = string
}

variable "resource_groups" {
  description = "Map of resource groups to create"
  type        = map(object({
    name     = string
    location = string
  }))
}
```

### terraform.tfvars

Create a `terraform.tfvars` file (based on `terraform.tfvars.example`) to provide values:

**Example `terraform.tfvars`:**
```hcl
subscription_id = "your-azure-subscription-id"

resource_groups = {
  dev = {
    name     = "dev-resource-group"
    location = "eastus"
  }
  prod = {
    name     = "prod-resource-group"
    location = "westus"
  }
}
```

**Key Point:** Variables enable infrastructure reusability across different environments without code duplication.

---

## 📤 Git Workflow

### Check Repository Status
```bash
git status
```
Shows modified, staged, and untracked files.

### Stage Changes
```bash
git add .
```
Stages all changes for commit.

### Commit Changes
```bash
git commit -m "Add dev and prod resource groups"
```
Creates a commit with a descriptive message.

### Push to Remote
```bash
git push
```
Uploads commits to the remote GitHub repository.

### Full Workflow Example
```bash
# Make infrastructure changes
# ...

# Check status
git status

# Stage all changes
git add .

# Commit with meaningful message
git commit -m "Create resource groups for staging environment"

# Push to GitHub
git push
```

---

## ✅ Best Practices

### 1. **Do Not Commit Terraform State Files**
```
❌ DO NOT commit:
- terraform.tfstate
- terraform.tfstate.backup
- .terraform/
```
These files contain sensitive data and local state information.

### 2. **Do Not Commit Variable Files with Secrets**
```
❌ DO NOT commit:
- terraform.tfvars
- *.tfvars (unless in *.tfvars.example for reference)
```

### 3. **Use .gitignore**
Ensure `.gitignore` excludes sensitive files. Example entries:
```
.terraform/
*.tfstate
*.tfstate.*
*.tfvars
.terraform.tfstate.lock.info
```

### 4. **Use Variables Instead of Hardcoded Values**
```hcl
# ❌ BAD - Hardcoded
location = "eastus"

# ✅ GOOD - Variable reference
location = var.location
```

### 5. **Use Remote State for Production**
For team environments, store state in **Azure Storage**:
```hcl
terraform {
  backend "azurerm" {
    resource_group_name  = "state-rg"
    storage_account_name = "tfstate"
    container_name       = "tfstate"
    key                  = "prod.tfstate"
  }
}
```

### 6. **Plan Before Apply**
Always review the plan before applying:
```bash
terraform plan -out=tfplan
terraform apply tfplan
```

### 7. **Use Meaningful Resource Names**
```hcl
# ✅ GOOD - Clear naming
resource "azurerm_resource_group" "dev_rg" { }

# ❌ BAD - Unclear naming
resource "azurerm_resource_group" "rg1" { }
```

### 8. **Document Resource Purpose**
```hcl
# ✅ GOOD - Description included
resource "azurerm_resource_group" "RGrp" {
  description = "Production resource group for Azure infrastructure"
  # ...
}
```

---

## 🔧 Troubleshooting

### Common Errors and Solutions

#### 1. Error: `subscription_id is required`
**Cause:** Missing or invalid subscription ID in provider configuration.

**Solution:**
```bash
# Verify your subscription ID
az account show --query id -o tsv

# Update terraform.tfvars
subscription_id = "your-correct-subscription-id"
```

#### 2. Error: `Error creating Resource Group: ResourceGroupsClient.CreateOrUpdate`
**Cause:** Authentication failed or insufficient permissions.

**Solution:**
```bash
# Re-authenticate with Azure
az logout
az login

# Verify permissions
az role assignment list --assignee $(az account show --query user.name -o tsv)
```

#### 3. Error: `Failed to query available provider packages`
**Cause:** Provider initialization issue or network connectivity problem.

**Solution:**
```bash
# Reinitialize Terraform
rm -rf .terraform/
terraform init

# Verify provider version
terraform version
```

#### 4. Error: `Error: Missing required argument "subscription_id"`
**Cause:** Variable not defined in `terraform.tfvars`.

**Solution:**
```bash
# Create terraform.tfvars from example
cp terraform.tfvars.example terraform.tfvars

# Edit and add your subscription ID
nano terraform.tfvars
```

#### 5. Error: `Resource group already exists`
**Cause:** Resource already exists in Azure with the same name.

**Solution:**
```bash
# Option 1: Import existing resource
terraform import azurerm_resource_group.RGrp /subscriptions/SUB_ID/resourceGroups/RG_NAME

# Option 2: Change resource name in configuration
# Update resource_groups variable with unique names
```

### Enable Debug Logging
```bash
export TF_LOG=DEBUG
terraform apply
unset TF_LOG
```

---

## 🚀 Future Enhancements

### Short-term Improvements
- [ ] **Terraform Remote State in Azure Storage** - Implement backend configuration for team state management
- [ ] **Terraform Modules** - Refactor into reusable modules for resource groups, networking, etc.
- [ ] **Multiple Environments** - Support dev, test, staging, and production configurations

### CI/CD Integration
- [ ] **GitHub Actions** - Automate `terraform plan` and `terraform apply` on pull requests
- [ ] **Azure DevOps Pipeline** - Implement automated deployment pipeline
- [ ] **Terraform Plan/Apply Automation** - Triggered on repository events

### Advanced Features
- [ ] **Azure Policy** - Enforce compliance and governance policies
- [ ] **Azure Monitor & Logging** - Implement monitoring and alerting for resources
- [ ] **Cost Management** - Add budget alerts and cost optimization
- [ ] **Disaster Recovery** - Implement backup and recovery strategies

### Code Quality
- [ ] **Terraform Testing** - Add Terratest for infrastructure testing
- [ ] **Pre-commit Hooks** - Validate and format code before commits
- [ ] **Tagging Strategy** - Implement consistent resource tagging

---

## 📚 Additional Resources

- [Terraform Documentation](https://www.terraform.io/docs)
- [AzureRM Provider Documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [Azure CLI Reference](https://docs.microsoft.com/cli/azure/)
- [Terraform Best Practices](https://www.terraform.io/cloud-docs/recommended-practices)
- [Azure Well-Architected Framework](https://docs.microsoft.com/en-us/azure/architecture/framework/)

---

## 👨‍💼 Author

**Subhrajit Senapati**  
DevOps / Cloud Engineer

---

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

---

**Last Updated:** 2026  
**Terraform Version:** >= 1.0  
**AzureRM Provider Version:** 4.1.0
