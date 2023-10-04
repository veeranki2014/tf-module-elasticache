variable "component" {}
variable "env" {}
variable "subnet_ids" {}
variable "tags" {}
variable "sg_subnet_cidr" {}
variable "kms_key_arn" {}
variable "vpc_id" {}
variable "engine" {}
variable "node_type" {}
#variable "num_cache_nodes" {}
#variable "parameter_group_name" {}
variable "engine_version" {}
variable "port" {
  default = 6379
}
variable "replicas_per_node_group" {}
variable "num_node_groups" {}

