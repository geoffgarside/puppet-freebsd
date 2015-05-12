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

  anchor { 'freebsd::network::begin': } ->
  class { '::freebsd::network::routing': } ->
  class { '::freebsd::network::service': } ->
  anchor { 'freebsd::network::end': }

}
