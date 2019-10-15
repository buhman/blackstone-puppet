class acme::client (
  String $host,
) {
  file { '/etc/acme-client.conf':
    content => epp("${module_name}/acme-client.conf.epp", { 'host' => $host })
  }
}
