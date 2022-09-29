resource "aws_instance" "Prod-rock-VPC" {
  ami = var.ami-type
  instance_type = var.instance-type
  subnet_id = aws_subnet.public_sub1.id
  key_name                    = "boss"
  associate_public_ip_address = true



  vpc_security_group_ids = [
    aws_security_group.TF_SG.id 
  ]
 
  tags = {
    Name ="SERVER01"
    OS = "UBUNTU"
  }

   depends_on = [ aws_security_group.TF_SG ] 
}



resource "aws_instance" "Prod-rock-VPC-private" {
  ami = var.ami-type
  instance_type = var.instance-type
  subnet_id = aws_subnet.public_sub2.id
  key_name                    = "boss"
  associate_public_ip_address = true


  vpc_security_group_ids = [
     aws_security_group.TF_SG.id 
  ]
 
  tags = {
    Name ="SERVER02"
    OS = "UBUNTU"
  }

  depends_on = [ aws_security_group.TF_SG ] 
}





 resource "aws_security_group" "TF_SG" {
  name        = "security group using terraform"
  description = "security group using terraform"
  vpc_id      = aws_vpc.Prod-rock-VPC.id
   

 }
resource aws_security_group_rule"Allow_HTTP"{
    
    type            = "ingress"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
     security_group_id = aws_security_group.TF_SG.id
    
  } 

resource "aws_security_group_rule""Allow_SSH"{
    
    type            = "ingress"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    security_group_id = aws_security_group.TF_SG.id
} 





