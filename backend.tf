terraform {
  backend "s3" {
    bucket         = "sybill-terraform-state-bucket"
    key            = "dev/terraform.tfstate"
    region         = "ap-south-1"   # Update if using a different region
  }
}

