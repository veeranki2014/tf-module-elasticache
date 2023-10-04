resource "aws_elasticache_subnet_group" "main" {
  name       = "${var.component}-${var.env}"
  subnet_ids = var.subnet_ids
  tags              = merge ({ Name = "${var.component}-${var.env}" }, var.tags )
}

# Security Groups
resource "aws_security_group" "main" {
  name        = "${var.component}-${var.env}-sg"
  description = "${var.component}-${var.env}-sg"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = var.port
    to_port     = var.port
    protocol    = "tcp"
    cidr_blocks = var.sg_subnet_cidr

  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.component}-${var.env}-sg"
  }
}

##Redis Cluster Mode Disabled
#resource "aws_elasticache_cluster" "main" {
#  cluster_id           = "${var.component}-${var.env}"
#  engine               = var.engine
#  node_type            = var.node_type
#  num_cache_nodes      = var.num_cache_nodes
#  parameter_group_name = var.parameter_group_name
#  engine_version       = var.engine_version
#  port                 = var.port
#  subnet_group_name    = aws_elasticache_subnet_group.main.name
#  security_group_ids   = [ aws_security_group.main.id ]
#}

##Redis Cluster mode Enabled
resource "aws_elasticache_replication_group" "main" {
  replication_group_id       = "${var.component}-${var.env}"
  description                = "${var.component}-${var.env}"
  node_type                  = var.node_type
  port                       = var.port
  #parameter_group_name       = "default.redis3.2.cluster.on"
  automatic_failover_enabled = true

  num_node_groups           = var.num_node_groups
  replicas_per_node_group   = var.replicas_per_node_group
  subnet_group_name         = aws_elasticache_subnet_group.main.name
  security_group_ids        = [ aws_security_group.main.id]
  parameter_group_name      = "default.redis6.x.cluster.on"
  kms_key_id                = var.kms_key_arn
  engine                    = var.engine
  engine_version            = var.engine_version
  #storage_encrypted         = true
  #transit_encryption_enabled = true
  at_rest_encryption_enabled = true

}






