module "s3_bucket" {
        source = "terraform-aws-modules/s3-bucket/aws"

        bucket = local.bucket
        acl    = "private"

        versioning = {
        enabled = true
    }
}

resource "aws_s3_bucket" "bucket" {
    bucket = local.bucket
}

resource "aws_iam_policy" "s3_access_policy" {
  name        = "s3_access_policy"
  description = "Allow access to S3 bucket"
  policy      = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket"
            ],
            "Resource": [
                "arn:aws:s3:::$ {var.bucket_name}"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:PutObject",
                "s3:DeleteObject"
            ],
            "Resource": [
                "arn:aws:s3:::$ {var.bucket_name}/*"
            ]
        }
    ]
  }
  EOF
}

resource "aws_iam_role_policy_attachment" "attach_s3_access_policy" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = aws_iam_policy.s3_access_policy.arn
}
