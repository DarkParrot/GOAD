terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.46.3"
    }
  }
}

provider "proxmox" {
  endpoint = var.pm_api_url
  username = var.pm_user
  password = var.pm_password
  insecure = true

  # ssh {
  #   agent = true
  #   # TODO: uncomment and configure if using api_token instead of password
  #   # username = "root"
  # }

}
