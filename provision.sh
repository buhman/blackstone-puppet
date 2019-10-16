pkg_add facter-3.14.4 puppet-5.5.16p1
mkdir -p /etc/puppetlabs/facter/external
cat <<EOF> /etc/puppetlabs/facter/external/hostname.json
{
    "hostname": "blackwater"
}
EOF
cat <<EOF> /etc/puppetlabs/facter/facter.conf
global : {
  external-dir : ["/etc/puppetlabs/facter/external"]
}
EOF
