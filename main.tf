# Root module to deploy two EC2 instances: one WebSocket server and one client

provider "aws" {
  region = "us-east-1"
}

resource "aws_key_pair" "ws_key" {
  key_name   = "websocket_key"
  public_key = file("L:/terraform/awskey/publickey.pub")

}

resource "aws_security_group" "websocket_sg" {
  name        = "websocket_sg"
  description = "Allow WebSocket port and SSH"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = []
    cidr_blocks     = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "websocket_server" {
  ami           = "ami-0c94855ba95c71c99" # Ubuntu 20.04 (us-east-1)
  instance_type = "t2.micro"
  key_name      = aws_key_pair.ws_key.key_name
  security_groups = [aws_security_group.websocket_sg.name]
  user_data = file("server_user_data.sh")

  tags = {
    Name = "WebSocketServer"
  }
}

resource "aws_instance" "websocket_client" {
  ami           = "ami-0c94855ba95c71c99"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.ws_key.key_name
  security_groups = [aws_security_group.websocket_sg.name]
  user_data = templatefile("client_user_data.sh.tpl", {
    server_private_ip = aws_instance.websocket_server.private_ip
  })

  tags = {
    Name = "WebSocketClient"
  }
}

output "server_public_ip" {
  value = aws_instance.websocket_server.public_ip
}

output "client_public_ip" {
  value = aws_instance.websocket_client.public_ip
}

output "server_private_ip" {
  value = aws_instance.websocket_server.private_ip
}
