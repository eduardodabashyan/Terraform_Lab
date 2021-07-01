locals {
  env = terraform.workspace
}

variable "profile" {
  type    = string
  default = "default"
}


variable "region" {
  type = map(any)
  default = {
    dev  = "us-west-2"
    prod = "us-east-1"
  }
}

variable "instance-type" {
  type    = string
  default = "t2.micro"
}


variable "ami-id" {
  type = map(any)
  default = {
    dev  = "ami-07a29e5e945228fa1"
    prod = "ami-09e67e426f25ce0d7"
  }
}


variable "book_dbadmin" {
  type    = string
  default = "root"
}

variable "book_dbpass" {
  type    = string
  default = "bookadmin"
}

variable "movie_dbadmin" {
  type    = string
  default = "root"
}

variable "movie_dbpass" {
  type    = string
  default = "movieadmin"
}