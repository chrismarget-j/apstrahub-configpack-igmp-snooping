#  Copyright (c) Juniper Networks, Inc., 2025-2025.
#  All rights reserved.
#  SPDX-License-Identifier: MIT

resource "apstra_datacenter_configlet" "example" {
  blueprint_id = var.blueprint_id
  name = var.name
  condition = "role in [\"leaf\", \"access\"]"
  generators = [
    {
      config_style  = "junos"
      section       = "top_level_hierarchical"
      template_text = <<-EOT
        {% for vlan, vlan_info in vlan.items() %}
        {% if 'mcast' in vlan_info.name %}
        protocols {
          igmp-snooping {
            vlan vn{{ vlan_info.id }}
          }
        }
        {% endif %}
        {% endfor %}
      EOT
    },
  ]
}
