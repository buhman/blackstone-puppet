class rspamd::service {
  service { 'redis':
    ensure => 'running',
    enable => true,
  }

  service { 'rspamd':
    ensure => 'running',
    enable => true,
  }
}
