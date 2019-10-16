class smtpd (
  String $mail_domain,
) {
  file { '/etc/mail/dkim':
    ensure => directory,
  }

  file { "/etc/mail/dkim/${::hostname}.key":
    source => "puppet:///modules/${module_name}/dkim/${::hostname}.key",
  }

  file { '/etc/mail/smtpd.conf':
    content => epp("${module_name}/smtpd.conf.epp", {
      'mail_domain' => $mail_domain,
    }),
    notify  => Service['smtpd'],
  }

  package { [ 'opensmtpd-filter-senderscore',
              'opensmtpd-filter-rspamd',
            ]:
    ensure => installed,
  }

  service { 'smtpd':
    ensure => 'running',
    enable => true,
  }
}
