class opensmtpd::dkim {
  file { '':
    source => "puppet:///modules/${module_name}/dkim/${::hostname}.key"
  }
}
