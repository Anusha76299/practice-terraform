resource "aws_db_instance" "myrds1" {
  allocated_storage    = 10
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  username             = "anu"
  password             = "Vison.24#"
  skip_final_snapshot  = true
  publicly_accessible  = true
  # db_snapshot_identifier = aws_db_snapshot.sn1.id
  # aws_db_subnet_group = aws_db_subnet_group.default.name 
  multi_az            = false
  #vpc_security_group_ids = [aws_security_group.sg1.id]
}
