/*variable "s3_bucket_name" {
  type    = list(string)
  default = ["lcp-aa", "lcp-bb"]
}*/

variable "environment" {
  default = "Development"
}

variable "kms_id" {
  type    = string
  default = "7a16c24c-54c1-42af-a272-7ae66994d74f"
}

variable "s3_bucket" {
  type = list(string)
  default = ["lacp-terraform-development",
    "iaac-dna-pipe-prod",
    "iaac-dna-pipe-prod-backup",
    "iaac-dna-pipe-prod-restore-restore",
    "lacp-lksprod",
    "lcp-admin-production",
    "lcp-data-production",
    "lcp-email-service-production-templates",
    "lcp-instance-service-production-attachments",
    "lcp-opa-production",
    "lcp-skillsoft-content-production",
    "lcp-swagger-production-config",
    "lcp-test-results",
  "lcp-translation-digital-enrollments-production"]
}