

variable "aws_region" {
    description     = "Desired aws region"
    type            = string
    default         = "us-east-1"
}

variable "ami_type" {
    description     = "Type of image"
    type            = string
    default         = "ami-0557a15b87f6559cf"
}


variable "instance_type" {
    description     = "Type of instance"
    type            = string
    default         = "t2.micro"
}


#################################################
####################--Tags--#####################
#################################################


variable "additional_tags" {

  description           = "Additional resource tags"
  type                  = map(string)

  default               = {
    "created_by"        = "Lev Meshorer"
    "creation_date"     = "26.03.2023"
    "deployed_with"     = "Terraform"
  }

}


