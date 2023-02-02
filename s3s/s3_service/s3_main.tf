data "aws_kms_key" "kms_id" {
  key_id = var.kms_id
}

/*module "s3_bucket_msk_logs" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 3.6"
  bucket = lower(format("iaac-bucket-msk-logs-%s", var.environment) )
  acl    = "private"
  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        kms_master_key_id = data.aws_kms_key.kms_id.id
        sse_algorithm = "aws:kms"
      }
    }
  }
}

module "s3_bucket_eks_logs" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 3.6"
  bucket = lower(format("iaac-bucket-eks-logs-%s", var.environment) )
  acl    = "private"
  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        kms_master_key_id = data.aws_kms_key.kms_id.id
        sse_algorithm = "aws:kms"
      }
    }
  }
}

module "s3_bucket_dna_pipe_logs" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 3.6"
  bucket = lower(format("iaac-dna-pipe-prod-%s", var.environment) )
  acl    = "private"
  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        kms_master_key_id = data.aws_kms_key.kms_id.id
        sse_algorithm = "aws:kms"
      }
    }
  }
}

module "s3_bucket_dna_pipe_backup_logs" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 3.6"
  bucket = lower(format("iaac-dna-pipe-prod-backup-%s", var.environment) )
  acl    = "private"
  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        kms_master_key_id = data.aws_kms_key.kms_id.id
        sse_algorithm = "aws:kms"
      }
    }
  }
}

module "s3_bucket_dna_pipe_restore_logs" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 3.6"
  bucket = lower(format("iaac-dna-pipe-prod-restore-%s", var.environment) )
  acl    = "private"
  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        kms_master_key_id = data.aws_kms_key.kms_id.id
        sse_algorithm = "aws:kms"
      }
    }
  }
}

module "s3_bucket_lksprod" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 3.6"
  bucket = lower(format("iaac-lacp-lksprod-%s", var.environment) )
  acl    = "private"
  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        kms_master_key_id = data.aws_kms_key.kms_id.id
        sse_algorithm = "aws:kms"
      }
    }
  }
}

module "s3_bucket_lcp_admin" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 3.6"
  bucket = lower(format("iaac-lcp-admin-production-%s", var.environment) )
  acl    = "private"
  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        kms_master_key_id = data.aws_kms_key.kms_id.id
        sse_algorithm = "aws:kms"
      }
    }
  }
}

module "s3_bucket_data_production" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 3.6"
  bucket = lower(format("iaac-lcp-data-production-%s", var.environment) )
  acl    = "private"
  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        kms_master_key_id = data.aws_kms_key.kms_id.id
        sse_algorithm = "aws:kms"
      }
    }
  }
}

module "s3_bucket_email_service" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 3.6"
  bucket = lower(format("iaac-email-service-production-templates-%s", var.environment) )
  acl    = "private"
  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        kms_master_key_id = data.aws_kms_key.kms_id.id
        sse_algorithm = "aws:kms"
      }
    }
  }
}

module "s3_bucket_instance" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 3.6"
  bucket = lower(format("iaac-instance-service-production-attachments-%s", var.environment) )
  acl    = "private"
  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        kms_master_key_id = data.aws_kms_key.kms_id.id
        sse_algorithm = "aws:kms"
      }
    }
  }
}

module "s3_bucket_opa" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 3.6"
  bucket = lower(format("iaac-lcp-opa-production-%s", var.environment) )
  acl    = "private"
  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        kms_master_key_id = data.aws_kms_key.kms_id.id
        sse_algorithm = "aws:kms"
      }
    }
  }
}

module "s3_bucket_skillsoft" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 3.6"
  bucket = lower(format("iaac-skillsoft-content-production-%s", var.environment) )
  acl    = "private"
  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        kms_master_key_id = data.aws_kms_key.kms_id.id
        sse_algorithm = "aws:kms"
      }
    }
  }
}

module "s3_bucket_swagger" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 3.6"
  bucket = lower(format("iaac-swagger-production-config-%s", var.environment) )
  acl    = "private"
  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        kms_master_key_id = data.aws_kms_key.kms_id.id
        sse_algorithm = "aws:kms"
      }
    }
  }
}

module "s3_bucket_test_results" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 3.6"
  bucket = lower(format("iaac-test-results-%s", var.environment) )
  acl    = "private"
  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        kms_master_key_id = data.aws_kms_key.kms_id.id
        sse_algorithm = "aws:kms"
      }
    }
  }
}

module "s3_bucket_translation" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 3.6"
  bucket = lower(format("iaac-translation-digital-enrollments-production-%s", var.environment) )
  acl    = "private"
  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        kms_master_key_id = data.aws_kms_key.kms_id.id
        sse_algorithm = "aws:kms"
      }
    }
  }
}*/
###################################################################################
####### S3 bucket creation #######################################################
module "s3_bucket_translation" {
  count   = length(var.s3_bucket)
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 3.6"
  bucket  = lower(format("${var.s3_bucket[count.index]}-%s", var.environment))
  acl     = "private"
  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        kms_master_key_id = data.aws_kms_key.kms_id.id
        sse_algorithm     = "aws:kms"
      }
    }
  }
  versioning = {
    enabled = true
  }
}


/*data "aws_s3_bucket" "s3_bucket" {
  bucket = "lacp-terraform-development"
}*/

##############################################################################
################ IAM for s3 replication #####################################
resource "aws_iam_role" "replication" {
  name = "iaac-s3-replica-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "s3.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

resource "aws_iam_policy" "replication" {
  name = "iaac-replica-policy"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:GetReplicationConfiguration",
        "s3:ListBucket"
      ],
      "Effect": "Allow",
      "Resource": [
        "${module.s3_bucket_translation[0].s3_bucket_arn}"
      ]
    },
    {
      "Action": [
        "s3:GetObjectVersion",
        "s3:GetObjectVersionAcl"
      ],
      "Effect": "Allow",
      "Resource": [
        "${module.s3_bucket_translation[0].s3_bucket_arn}"
      ]
    },
    {
      "Action": [
        "s3:ReplicateObject",
        "s3:ReplicateDelete"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
POLICY
}

resource "aws_iam_policy_attachment" "replication" {
  name       = "iaac-replica-policy-attachment"
  roles      = [aws_iam_role.replication.name]
  policy_arn = aws_iam_policy.replication.arn
}


###############################################################################
############### s3 replica ###################################################
##############################################################################
module "s3_bucket_replica" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 3.6"
  providers = {
    aws = aws.replica
  }
  bucket = lower(format("iaac-s3-replica-%s", var.environment))
  acl    = "private"
  versioning = {
    "enabled" = true
  }
  replication_configuration = {
    role = aws_iam_role.replication.arn
    rules = [
      {
        id                        = lower(format("iaac-s3Bucket-replica-%s", var.environment))
        status                    = "Enabled"
        delete_marker_replication = true
        destination = {
          #bucket = data.aws_s3_bucket.s3_bucket.arn
          bucket        = "${module.s3_bucket_translation[0].s3_bucket_arn}"
          storage_class = "STANDARD"
        }
      }
    ]
  }
  depends_on = [
    module.s3_bucket_translation
  ]
}

 