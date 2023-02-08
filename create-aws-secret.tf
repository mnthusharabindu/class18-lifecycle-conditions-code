# Firstly create a random generated password to use in secrets. 
resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()"
}

# Creating a AWS secret for database master account (Masteraccoundb)

resource "aws_secretsmanager_secret" "devopsb30secret1" {
  name = "devopsb30secret1"
}

# Creating a AWS secret versions for database master account (Masteraccoundb)

resource "aws_secretsmanager_secret_version" "sversion" {
  secret_id     = aws_secretsmanager_secret.devopsb30secret1.id
  secret_string = <<EOF
   {
    "username": "adminaccount",
    "password": "${random_password.password.result}"
   }
EOF
}


#Testing Special Characters
resource "random_password" "password2" {
  length           = 16
  special          = true
  min_special      = 4
  override_special = "!#$%&*()"
}

resource "aws_secretsmanager_secret" "devopsb30secret2" {
  name = "devopsb30secret2"
}

resource "aws_secretsmanager_secret_version" "sversion2" {
  secret_id     = aws_secretsmanager_secret.devopsb30secret2.id
  secret_string = <<EOF
   {
    "username": "adminaccount",
    "password": "${random_password.password2.result}"
   }
EOF
}