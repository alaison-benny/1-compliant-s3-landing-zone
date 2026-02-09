# 🛡️ Compliant S3 Landing Zone (EU AI Act Ready)

This repository contains a **Terraform** template for deploying a secure AWS S3 environment specifically designed for AI workloads (Training Data & Model Weights).

### ⚖️ Regulatory Alignment
This architecture is designed to meet the following standards:
- **EU AI Act Art. 10:** Data Governance & Management.
- **GDPR Art. 32:** Security of Processing (Encryption at rest).
- **ISO/IEC 27001:** Key rotation and access controls.

### 🛠️ Key Features
- **Region Locking:** Set to `eu-central-1` (Germany) to ensure EU data residency.
- **KMS Encryption:** Automatic encryption using AWS KMS with **Key Rotation** enabled.
- **Data Lineage:** Versioning enabled to track changes in training datasets.
- **Zero Public Access:** Explicitly blocks all public ACLs and policies.

### 🚀 How to use
1. `terraform init`
2. `terraform plan`
3. `terraform apply`

**Developed by Alaison | Founder of ActReady AI**
