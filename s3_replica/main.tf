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
        "${data.aws_s3_bucket.s3bucket-destination1.arn}"
      ]
    },
    {
      "Action": [
        "s3:GetObjectVersion",
        "s3:GetObjectVersionAcl"
      ],
      "Effect": "Allow",
      "Resource": [
        "${data.aws_s3_bucket.s3bucket-destination1.arn}"
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

#######################source bucket#################################################333
data "aws_s3_bucket" "s3bucket-source1"{
bucket = "s3bucket-source1"
}

#################################################################################3333
data "aws_s3_bucket" "s3bucket-destination1" {
    bucket = "s3bucket-destination1"
}
###############################################################################
############### s3 replica ###################################################
##############################################################################
module "s3_bucket_replica" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 3.6"
  /*providers = {
    aws = aws.replica
  }*/
  #bucket = lower(format("iaac-s3-replica-%s", var.environment))
  bucket = data.aws_s3_bucket.s3bucket-source1.arn
  acl    = "private"
  versioning = {
    "enabled" = true
  }
  replication_configuration = {
    role = aws_iam_role.replication.arn
    rules = [
      {
        id                        = "iaac-s3Bucket-replica-%s"
        status                    = "Enabled"
        delete_marker_replication = true
        destination = {
          bucket = data.aws_s3_bucket.s3bucket-destination1.arn
          #bucket        = "${module.s3_bucket_translation[0].s3_bucket_arn}"
          storage_class = "STANDARD"
        }
      }
    ]
  }
  depends_on = [
    #module.s3_bucket_translation
    data.aws_s3_bucket.s3bucket-source1
  ]
}
