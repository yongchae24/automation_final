locals {
  common_tags = {
    Assignment    = "CCGC 5502 Automation Project"
    Name          = "yongchae.ko"
    ExpirationDate= "2024-12-31"
    Environment   = "Project"
  }
}

module "rgroup-n01649144" {
  source  = "./modules/rgroup-n01649144"

  common_tags = local.common_tags
}

module "network-n01649144" {
  source = "./modules/network-n01649144"

  common_tags = local.common_tags
  depends_on = [module.rgroup-n01649144]

}

module "vmlinux-n01649144" {
  source              = "./modules/vmlinux-n01649144"
  subnet_id           = module.network-n01649144.subnet_id

  common_tags         = local.common_tags
  depends_on          = [module.rgroup-n01649144, module.network-n01649144]
}

resource "null_resource" "ansible_playbook" {
  depends_on = [module.vmlinux-n01649144]

  provisioner "local-exec" {
    command = "ansible-playbook -i ~/n01649144/automation/ansible/hosts ~/n01649144/automation/ansible/n01649144-playbook.yml"
  }

  triggers = {
    always_run = "${timestamp()}"
  }
}