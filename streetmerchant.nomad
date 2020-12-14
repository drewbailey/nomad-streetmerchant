job "streetmerchant" {
  datacenters = ["homelab"]

  group "group" {

    task "task" {
      driver = "docker"

      template {
        data        = <<EOH
AUTO_ADD_TO_CART="false"
COUNTRY="usa"
DESKTOP_NOTIFICATIONS="false"
MAX_PRICE_SERIES_3070="700"
MAX_PRICE_SERIES_3080="800"
MAX_PRICE_SERIES_3090="800"
MICROCENTER_LOCATION="st-davids"
TWILIO_TO_NUMBER="{{key "streetmerchant/twilio_to_number"}}"
TWILIO_FROM_NUMBER="{{key "streetmerchant/twilio_from_number"}}"
TWILIO_AUTH_TOKEN="{{key "streetmerchant/twilio_auth_token"}}"
TWILIO_ACCOUNT_SID="{{key "streetmerchant/twilio_account_sid"}}"
EOH
        change_mode = "restart"
        destination = "local/sm.conf"
        env         = true
      }

      config {
        cap_add = ["SYS_ADMIN"]
        image   = "ghcr.io/jef/streetmerchant:nightly"
      }

      resources {
        cpu    = 500
        memory = 500
      }
    }
  }
}
