# == Class: freebsd::network
#
# Manage simple network parameters in /etc/rc.conf
#
# == Parameters:
#
# [*defaultrouter*]
#   Set the default IPv4 router IP.
#
# [*gateway_enable*]
#   Enables IP forwarding on IPv4.
#
# [*ipv6_defaultrouter*]
#   Set the default IPv6 router IP.
#
# [*ipv6_gateway_enable*]
#   Enables IP forwarding on IPv6
#
# === Authors
#
# Geoff Garside <puppet@geoffgarside.co.uk>
#
# === Copyright
#
# Copyright 2014 Geoff Garside, unless otherwise noted.
#
class freebsd::network (
  $defaultrouter       = undef,
  $gateway_enable      = undef,
  $ipv6_defaultrouter  = undef,
  $ipv6_gateway_enable = undef,
) {
  include ::stdlib
  include ::freebsd::params

  # Set a default router if we have one, don't override if undef
  if $defaultrouter {
    if is_ip_address($defaultrouter) {
      freebsd::rc_conf { 'defaultrouter':
        value => $defaultrouter
      }
    } else {
      fail("defaultrouter '${defaultrouter}' is not a valid IP address")
    }
  }

  # Set an IPv6 default router if we have one, don't override if undef
  if $ipv6_defaultrouter {
    if is_ip_address($ipv6_defaultrouter) {
      freebsd::rc_conf { 'ipv6_defaultrouter':
        value => $ipv6_defaultrouter
      }
    } else {
      fail("ipv6_defaultrouter '${ipv6_defaultrouter}' is not a valid IP address")
    }
  }

  freebsd::rc_conf {
    'gateway_enable':      value => $gateway_enable;
    'ipv6_gateway_enable': value => $ipv6_gateway_enable;
  }

  exec { $::freebsd::params::netif_cloneup:
    command     => 'service netif cloneup',
    path        => ['/bin', '/sbin', '/usr/bin', '/usr/sbin'],
    refreshonly => true,
  }
}
