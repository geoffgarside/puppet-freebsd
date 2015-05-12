# == Class: freebsd::network::routing
#
# Manage simple network routing parameters in /etc/rc.conf
#
# === Authors
#
# Geoff Garside <puppet@geoffgarside.co.uk>
#
# === Copyright
#
# Copyright 2014 Geoff Garside, unless otherwise noted.
#
class freebsd::network::routing {
  include ::stdlib
  include ::freebsd::params

  $defaultrouter       = $::freebsd::network::defaultrouter
  $gateway_enable      = $::freebsd::network::gateway_enable
  $ipv6_defaultrouter  = $::freebsd::network::ipv6_defaultrouter
  $ipv6_gateway_enable = $::freebsd::network::ipv6_gateway_enable

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
}
