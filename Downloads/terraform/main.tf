provider "aws"{
  region      ="us-east-2"
  access_key  ="AKIAVQBZ2JUC6QO72EVL"
  secret_key  ="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"
}
resource "aws_instance" "janu-ec2-instance"{
   ami           ="ami-0b614a5d911900a9b"
   instance_type ="t2.micro"
   count = "2"
}

