type = "csi"
id = "nfs"
name = "homeassistant-config"
plugin_id = "nfs"

capability {
  access_mode = "multi-node-multi-writer"
  attachment_mode = "file-system"
}

capability {
  access_mode = "single-node-writer"
  attachment_mode = "file-system"
}

context {
  server = "192.168.2.12"
  share = "/homelab/homeassistant/config"
}

mount_options {
  fs_type = "nfs"
}
