class httpd::acme (
  String $host,
) {
  file { '/etc/httpd.conf':
    content => epp("${module_name}/httpd-acme.conf.epp", { 'host' => $host })
  }
}
