/*
#create RDS
resource "aws_db_instance" "yz-db" {
    engine = "mysql"
    db_name = "dbterraform1"
    identifier = "terraforminstance"
    instance_class = "db.t3.micro"
    deletion_protection = false
    iam_database_authentication_enabled = false
    multi_az = false
    port = 3306
    publicly_accessible = true
    username = "admin"
    password = "somepassword"
    vpc_security_group_ids = [aws_security_group.db_sg.id]
    allocated_storage = 200
}
*/