#Create Movie DB
resource "aws_db_instance" "movie-db" {

  identifier             = "movie"
  storage_type           = "gp2"
  port                   = 3306
  db_subnet_group_name   = "main"
  vpc_security_group_ids = [var.db_sg] 
  allocated_storage      = 10
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t2.micro"
  name                   = "moviedb"
  username               = var.movie_dbadmin
  password               = var.movie_dbpass
  # parameter_group_name = "movie-db.mysql5.7"
  skip_final_snapshot = true
  # deletion_protection  = true

  tags = {
    Name = "MySQL RDS server for LAMP project"
  }
}


#Create Book DB
resource "aws_db_instance" "book-db" {

  identifier             = "book"
  storage_type           = "gp2"
  port                   = 3306
  db_subnet_group_name   = "main"
  vpc_security_group_ids = [var.db_sg]   
  allocated_storage      = 10
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t2.micro"
  name                   = "bookstore"
  username               = var.book_dbadmin
  password               = var.book_dbpass
  # parameter_group_name = "book-db.mysql5.7"
  skip_final_snapshot = true
  # deletion_protection  = true
}


#Create subnet group
resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "main"
  subnet_ids = [var.sub_1, var.sub_2]

  tags = {
    Name = "My DB subnet group"
  }
}