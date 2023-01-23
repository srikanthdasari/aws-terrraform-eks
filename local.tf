locals {
  cluster_name = "dasari-eks-${random_string.suffix.result}"
  name = "dasari"
  bucket = "dasari-s3-bucket"
}
