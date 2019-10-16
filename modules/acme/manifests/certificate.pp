class acme::certificate (
  String $host,
) {
  class { 'httpd::acme':
    host => $host,
  }

  file { '/etc/acme-client.conf':
    content => epp("${module_name}/acme-client.conf.epp", { 'host' => $host }),
    notify  => Exec["acme-client ${host}"],
  }

  exec { "acme-client ${host}":
    path    => ['/usr/sbin'],
    creates => "/etc/ssl/${host}.fullchain.pem",
  }

  cron { "acme-client ${host}":
    command  => "/usr/sbin/acme-client ${host}",
    user     => 'root',
    minute   => fqdn_rand(60, 'acme-client'),
    hour     => absent,
    monthday => absent,
    month    => absent,
    weekday  => absent,
  }
}
