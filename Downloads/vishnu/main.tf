provider "aws" {
   region     = "us-east-2"
   access_key = "AKIAVQBZ2JUC5KR365GO"
   secret_key = "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"
}

resource "aws_instance" "jhansi-ec2-instance" {
    ami = "ami-0b614a5d911900a9b"  
    instance_type = "t2.micro" 
    tags          = {
    Name        = "myjanu"  
  }
    key_name= "aws_key"
    vpc_security_group_ids = [aws_security_group.main.id]
  provisioner "remote-exec" {
    inline = [
      "touch hello.txt",
      "echo helloworld remote provisioner >> hello.txt",
    ]   
}
  connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ec2-user"
      private_key = file("~/.ssh/id_rsa")
      timeout     = "4m"
   }
}

resource "aws_security_group" "main" {
  egress = [
    {
      cidr_blocks      = [ "0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
 ingress                = [
   {
     cidr_blocks      = [ "0.0.0.0/0", ]
     description      = ""
     from_port        = 22
     ipv6_cidr_blocks = []
     prefix_list_ids  = []
     protocol         = "tcp"
     security_groups  = []
     self             = false
     to_port          = 22
  }
  ]
}

resource "aws_key_pair" "developer" {
  key_name   = "aws_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC40TXSlwauau1x4bk5iE9jdTZXrbTGU4YQZfpE1GJowWDU7LgR1msWFXI+PVL+uO5rxVnf05PXoWrFlPmNSuVEOznQRLhh9WXRXA22U+sj7EPAgM3SLkyI0bJPbISEDW0ae7DE6gbcTYpCperp/3RuwfkqHsnBNLvHxrFNKIktuCBhi27G+NZmvf9YVpNektNwxQRr4jT2jrk3uTtnIZDWiy7kwSrv2QRyJBEjJYdoMOmyf/MCc7cAz5O6vIlkEGu8Y2Eaaqu33pWk63ybA7jEwz+Lu9OhIXU5Nuz9BtD28cK6KCzY2glFKYwSh+EMi3QEUQrDIJG+kKB7ZQzF5vKEdRH1dIxaBTK9jphFO9eomoLfhUym/O1uxeXekqL+5moPqotL84WLn1nlSFgnNtQBvd+0ojfY8UZCz4vL3gc17yKNyyz+fN/RFyHWEdsrrVtIE8Da9AEawe+1IgGxSq0M+VhNvr3dLjLgF+B6bZ+OL/5YcCTw8UW8Td8aXGLSPest/nLTssXdQe74S8jSkMFJishF4LKZX1MvgnhkYc8SCgomGhoNDi3JppkxEYLFmkZp3ZRHtPHOThTSeEAFs8MC8LIUcnVdQuNAmUa546Ypy1CiQzxFypmis21BUt77ABkO399KflphW7l1tzwcQbXqO57dgYMvKUBbv0ay6zuBbQ== beerejhansirani2408@gmail.com"
}

