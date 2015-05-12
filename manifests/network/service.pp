# == Class: freebsd::network::service
#
# Manage network service exec operations
#
# === Authors
#
# Geoff Garside <puppet@geoffgarside.co.uk>
#
# === Copyright
#
# Copyright 2014 Geoff Garside, unless otherwise noted.
#
class freebsd::network::service {
  include ::freebsd::params

  exec { $::freebsd::params::netif_cloneup:
    command     => 'service netif cloneup',
    path        => ['/bin', '/sbin', '/usr/bin', '/usr/sbin'],
    refreshonly => true,
  }
}
