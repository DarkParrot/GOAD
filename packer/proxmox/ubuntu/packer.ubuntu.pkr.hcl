source "proxmox-iso" "ubuntu" {
  additional_iso_files {
    device   = "sata4"
    iso_file = "local:iso/virtio-win.iso"
    unmount  = true
  }
  cloud_init              = true
  cloud_init_storage_pool = "${var.proxmox_iso_storage}"
  #communicator            = "winrm"
  cores                   = "${var.vm_cpu_cores}"
  disks {
    disk_size         = "${var.vm_disk_size}"
    format            = "${var.vm_disk_format}"
    storage_pool      = "${var.proxmox_vm_storage}"
    type              = "sata"
  }
  insecure_skip_tls_verify = "${var.proxmox_skip_tls_verify}"
  iso_file                 = "${var.iso_file}"
  iso_checksum             = "${var.iso_checksum}"
  iso_storage_pool         = "${var.proxmox_vm_storage}"
  memory                   = "${var.vm_memory}"
  network_adapters {
    bridge = "vmbr0"
    model  = "virtio"
  }
  node                 = "${var.proxmox_node}"
  os                   = "${var.os}"
  password             = "${var.proxmox_password}"
  pool                 = "${var.proxmox_pool}"
  proxmox_url          = "${var.proxmox_url}"
  sockets              = "${var.vm_sockets}"
  template_description = "${var.template_description}"
  template_name        = "${var.vm_name}"
  username             = "${var.proxmox_username}"
  vm_name              = "${var.vm_name}"
  task_timeout         = "40m"
  ssh_password         = "${var.vm_ssh_password}"
  ssh_username         = "${var.vm_ssh_user}"
  ssh_timeout          = "15m"
  unmount_iso          = true
  http_directory       = "http"
  boot_command         = ["c",
    "linux /casper/vmlinuz --- autoinstall ds='nocloud-net;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/' ",
    "<enter><wait>",
    "initrd /casper/initrd<enter><wait>",
    "boot<enter>"]
}

build {
  sources = ["source.proxmox-iso.ubuntu"]

  provisioner "shell" {
    inline = ["while [ ! -f /var/lib/cloud/instance/boot-finished ]; do echo 'Waiting for cloud-init...'; sleep 1; done"]
  }

}
