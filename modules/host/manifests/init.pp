class host (
  String $hostname,
  String $domain,
  String $root_hash,
  String $buhman_hash,
  String $buhman_key,
) {
  user { 'root':
    ensure   => present,
    password => $root_hash,
  }

  user { 'buhman':
    ensure   => present,
    password => $buhman_hash,
  }

  ssh_authorized_key { 'buhman@wooli':
    ensure => present,
    user   => 'buhman',
    type   => 'ssh-ed25519',
    key    => $buhman_key,
  }

  $fqdn = "${hostname}.${domain}"

  file { 'hostname':
    path    => '/etc/myname',
    content => "${fqdn}\n",
    owner   => 'root',
    group   => 'wheel',
    mode    => '0644',
  }

  exec { 'set hostname':
    path        => ['/bin'],
    command     => "hostname ${fqdn}",
    subscribe   => File['hostname'],
    refreshonly => true,
  }
}
