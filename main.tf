
# define a variable called instance_count but dont provide a default so that user will be prompted to provide

variable "instance_type" {}
variable "region" {}
variable "ami" {}
variable "instance_size" {}
variable "instance_count" {}
variable "instance_environment" {}
variable "name_description" {
  default = "notDefined"
}
variable "requester" {
  default = "g3sporter"
}

provider "aws" {
  region = var.region
}


# create a number of EC2 instances
resource "aws_instance" "my_instance" {
  #count = local.size[$var.size].count

  count = var.instance_count

  # The amazon machine image number (only valid in us-east-2)
  ami = var.ami
  # The instance size

  instance_type = var.instance_type

  #instance_type = "t2.micro"
  # Specify this block of tags on the resource
  tags = {
    # set the tag key: "Name"  = "g3sporter-1". Adding 1 to count.index because it starts at zero
    Name = "${var.requester}-${count.index + 1}"
  }
}

# Create an output with instance name and IP address
output "instance_ids" {
  # create a list of private_ip addresses of each instance
  value = aws_instance.my_instance[*].private_ip
}
