class profile::mailserver {
  include acme::certificate
  include httpd::service
  include rspamd
  include smtpd
}
