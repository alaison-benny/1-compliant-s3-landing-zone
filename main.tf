# ActReady AI - Compliant S3 Landing Zone
# Purpose: Secure storage for AI Training Data & Model Weights

provider "aws" {
  region = "eu-central-1" # Frankfurt (Ensures data stays in the EU)
}

# 1. THE ENCRYPTION KEY (Requirement: Data at rest must be encrypted)
resource "aws_kms_key" "ai_storage_key" {
  description             = "KMS Key for AI Training Data Encryption"
  deletion_window_in_days = 10
  enable_key_rotation     = true # Compliance Best Practice

  tags = {
    Name = "actready-kms-key"
  }
}

# 2. THE SECURE BUCKET
resource "aws_s3_bucket" "ai_data_bucket" {
  bucket = "actready-ai-training-data-${random_id.suffix.hex}"

  tags = {
    Compliance_Level = "High-Risk-AI"
    Owner            = "ActReady-AI"
  }
}

# 3. VERSIONING (Requirement: Data Lineage & Recovery)
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.ai_data_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

# 4. SERVER-SIDE ENCRYPTION (Requirement: GDPR Data Protection)
resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.ai_data_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.ai_storage_key.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

# 5. BLOCK PUBLIC ACCESS (Requirement: Prevent Data Leaks)
resource "aws_s3_bucket_public_access_block" "block_public" {
  bucket = aws_s3_bucket.ai_data_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "random_id" "suffix" {
  byte_length = 4
}
