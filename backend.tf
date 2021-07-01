terraform {
  backend "s3" {
    bucket  = "lampstatefile11113"
    key     = "terraformlampstate"
    region  = "us-west-2"
    profile = "default"
  }
}