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

REPO="${PWD}/blackwater-puppet"

rsync \
  --rsync-path=/usr/bin/openrsync \
  -arv "$REPO" buhman@blackwater.lan:~

puppet apply \
  --modulepath="${REPO}/modules" \
  --codedir="${REPO}/code" \
  --environment=rv \
  "${REPO}/code/environments/rv/manifests/site.pp"
