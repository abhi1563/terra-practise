
resource "aws_db_subnet_group" "db-subnet" {
  name       = "my-db-subnet"
  subnet_ids = [aws_subnet.sub1.id, aws_subnet.db-sub.id]
}

resource "aws_security_group" "db-sg" {
  name   = "db-sg"
  vpc_id = aws_vpc.newvpc.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_db_instance" "mydb" {
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  identifier             = "db1"
  username               = "admin"
  password               = "admin1234"
  allocated_storage      = 20
  db_subnet_group_name   = aws_db_subnet_group.db-subnet.id
  vpc_security_group_ids = [aws_security_group.db-sg.id]
  publicly_accessible    = true

  # A MySQL database named mydatabase will be automatically created when the RDS instance starts.

}
