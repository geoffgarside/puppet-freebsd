# == Class: freebsd
#
# Management and configuration of low level FreeBSD components.
#
# This module will setup the +/dev/fd+ and +/proc+ filesystems,
# manages permissions of +/etc/rc.conf+ and +/etc/rc.conf.d+,
# install kernel modules.
#
# === Examples
#
#  include freebsd
#
# See freebsd::mounts
#
# === Authors
#
# Geoff Garside <puppet@geoffgarside.co.uk>
#
# === Copyright
#
# Copyright 2014 Geoff Garside, unless otherwise noted.
#
class freebsd {
  class { '::freebsd::mounts': } ->
  class { '::freebsd::rcconf': } ->
  class { '::freebsd::kld_list': } ->
  Class['freebsd']

  class { '::freebsd::klds': }
}
