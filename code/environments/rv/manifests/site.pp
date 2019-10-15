node default {
  include profile::common
}

node blackwater {
  include profile::common
  include profile::mailserver
}
