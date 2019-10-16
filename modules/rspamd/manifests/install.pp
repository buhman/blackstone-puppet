class rspamd::install (
  String $dkim_host,
  String $dkim_selector,
) {
  package { 'rspamd':
    ensure => installed,
  }

  package { 'redis':
    ensure => installed,
  }

  file { '/etc/rspamd/local.d':
    ensure => directory,
  }

  file { '/etc/rspamd/local.d/dkim-signing.conf':
    content => epp("${module_name}/dkim-signing.conf.epp", {
      'dkim_host'     => $dkim_host,
      'dkim_selector' => $dkim_selector,
      'hostname'      => $::hostname,
    }),
    notify  => Service['rspamd'],
  }
}
