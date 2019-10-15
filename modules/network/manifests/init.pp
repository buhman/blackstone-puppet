#inet6 autoconf
#dhcp

class network (
  String $inet_addr,
  String $inet_mask,
  String $inet_brd,
  String $inet_gate,
  String $inet6_addr,
  String $inet6_prefixlen,
  String $inet6_gate,
  String $ula_addr,
  String $ula_prefixlen,
  String $domain,
  Array[String] $nameservers,
) {
  $interface = "dwge0"

  $hostname_if = @("IF"/L)
  inet ${inet_addr} ${inet_mask} ${inet_brd}
  inet6 ${inet6_addr} ${inet6_prefixlen}
  inet6 ${ula_addr} ${ula_prefixlen}
  | IF

  file { "/etc/hostname.${interface}":
    content => $hostname_if,
  }

  $mygate = @("MYGATE"/L)
  ${inet_gate}
  ${inet6_gate}%${interface}
  | MYGATE

  file { '/etc/mygate':
    content => $mygate,
  }

  $resolvconf = @(RESOLV/L)
  <%- | Array[String] $nameservers, | -%>
  domain rv.buhman.org
  <% $nameservers.each |$ns| { -%>
  nameserver <%= $ns %>
  <% } -%>
  lookup file bind
  | RESOLV

  file { '/etc/resolv.conf':
    content => inline_epp($resolvconf, { nameservers => $nameservers, }),
  }
}
