

variable "aws_region" {
    description     = "Desired aws region"
    type            = string
    default         = "us-east-2"
}

variable "ami_type" {
    description     = "Type of image"
    type            = string
    default         = "ami-00eeedc4036573771"
}


variable "instance_type" {
    description     = "Type of instance"
    type            = string
    default         = "t3.small"
}


#################################################
####################--Tags--#####################
#################################################


variable "additional_tags" {

  description           = "Additional resource tags"
  type                  = map(string)

  default               = {
    "created_by"        = "Lev Meshorer"
    "creation_date"     = "19.03.2023"
    "deployed_with"     = "Terraform"
  }

}


