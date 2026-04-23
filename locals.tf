locals {
  pools = [
    for pool in concat([var.control_pool], [var.worker_pool], var.additional_pools)
    : pool
  ]
}
