class httpd::service {
  service { 'httpd':
    ensure  => 'running',
    enable  => true,
    restart => 'rcctl reload httpd',
  }
}
