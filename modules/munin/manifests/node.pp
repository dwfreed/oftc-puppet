class munin::node {
  ensure_packages ([
    'munin-node',
    'libnet-ssleay-perl',
  ])

  service { 'munin-node':
    ensure => running,
    enable => true,
  }

  $muninaccess = hiera_array("muninaccess")
  define munin_node_allow {
    file_line { "munin-node allow $name":
      path => '/etc/munin/munin-node.conf',
      line => "allow $name",
      after => '^allow \^::1',
      require => Package['munin-node'],
      notify => Service['munin-node'],
    }
  }
  munin_node_allow { $muninaccess: }

  file_line { 'tls enabled':
    path => '/etc/munin/munin-node.conf',
    line => 'tls enabled',
    match => '^tls ',
    require => Package['munin-node'],
    notify => Service['munin-node'],
  }
  file_line { 'tls_verify_certificate no':
    path => '/etc/munin/munin-node.conf',
    line => 'tls_verify_certificate no',
    match => '^tls_verify_certificate ',
    require => Package['munin-node'],
    notify => Service['munin-node'],
  }
  file_line { 'tls_ca_certificate /etc/ssl/certs/thishost.pem':
    path => '/etc/munin/munin-node.conf',
    line => 'tls_ca_certificate /etc/ssl/certs/thishost.pem',
    match => '^tls_ca_certificate ',
    require => Package['munin-node'],
    notify => Service['munin-node'],
  }
  file_line { 'tls_private_key /etc/ssl/private/thishost.key':
    path => '/etc/munin/munin-node.conf',
    line => 'tls_private_key /etc/ssl/private/thishost.key',
    match => '^tls_private_key ',
    require => Package['munin-node'],
    notify => Service['munin-node'],
  }
  file_line { 'tls_certificate /etc/ssl/certs/thishost.pem':
    path => '/etc/munin/munin-node.conf',
    line => 'tls_certificate /etc/ssl/certs/thishost.pem',
    match => '^tls_certificate ',
    require => Package['munin-node'],
    notify => Service['munin-node'],
  }

  munin::plugin {[
    'cpu',
    'df',
    'df_abs',
    'df_inode',
    'diskstats',
    'fw_conntrack',
    'fw_packets',
    'interrupts',
    'load',
    'memory',
    'ntp_offset',
    'netstat',
    'processes',
  ]:}

  munin::plugin { 'if_eth0':
    plugin => 'if_',
  }
}
