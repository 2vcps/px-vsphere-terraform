resource "vsphere_virtual_machine" "pxfa1" {
  name             = "pxfa1-${count.index}"
  count            = "10"
  resource_pool_id = data.vsphere_resource_pool.pool1.id
  datastore_id     = data.vsphere_datastore.datastore.id
  folder           = "JO"
  wait_for_guest_ip_timeout = "-1"
  wait_for_guest_net_timeout = "-1"
  enable_disk_uuid = "true"

  num_cpus = 4
  memory   = 16000
  guest_id = data.vsphere_virtual_machine.template.guest_id

  scsi_type = data.vsphere_virtual_machine.template.scsi_type

  cdrom {
    client_device = true
  }

  network_interface {
    network_id   = data.vsphere_network.public.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }

  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.template.disks.0.size
    eagerly_scrub    = data.vsphere_virtual_machine.template.disks.0.eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.template.disks.0.thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      linux_options {
        host_name = "pxfa1-${count.index}"
        domain    = "fsa.lab"
      }
      network_interface {
        ipv4_address = "10.21.244.${200 + count.index}"
        ipv4_netmask = 24
      }
      

      ipv4_gateway = "10.21.244.1"
      dns_server_list = ["10.21.234.10","10.21.234.11"]
      dns_suffix_list = ["fsa.lab"]
    }
  }
}
