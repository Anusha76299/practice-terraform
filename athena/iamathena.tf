/*resource "aws_iam_role" "example" {
  name = "example_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "example_s3" {
  name = "example_s3_policy"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:ListBucket"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_policy" "example_athena" {
  name = "example_athena_policy"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "athena:*"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_policy" "example_glue" {
  name = "example_glue_policy"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "glue:*"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_policy" "example_grafana" {
  name = "example_grafana_policy"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "grafana:*"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "example_s3" {
  role = aws_iam_role.example.name
  policy_arn = aws_iam_policy.example_s3.arn
}

resource "aws_iam_role_policy_attachment" "example_athena" {
  role = aws_iam_role.example.name
  policy_arn = aws_iam_policy.example_athena.arn
}

resource "aws_iam_role_policy_attachment" "example_glue" {
  role = aws_iam_role.example.name
  policy_arn = aws_iam_policy.example_glue.arn
}

resource "aws_iam_role_policy_attachment" "example_grafana" {
  role = aws_iam_role.example.name
  policy_arn = aws_iam_policy.example_grafana.arn
}*/

/*resource "aws_iam_role" "example" {
  name = "example_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "grafana.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "example" {
  name = "example_policy"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "athena:*",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:Get*",
        "s3:List*"
      ],
      "Resource": "arn:aws:s3:::s3bucket-source1/*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "example" {
  role = aws_iam_role.example.name
  policy_arn = aws_iam_policy.example.arn
}*/



module "execution_role" {
  source = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  trusted_role_services = [
    "grafana.amazonaws.com"
  ]

  create_role = true


  role_name         = "grafana_role"
  role_requires_mfa = false
  #mfa_age = 0

  custom_role_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonGrafanaAthenaAccess"
  ]
  number_of_custom_role_policy_arns = 2
}