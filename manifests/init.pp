# == Class: freebsd
#
# Management and configuration of low level FreeBSD components.
#
# This module will setup the +/dev/fd+ and +/proc+
# filesystems, manage permissions of +/etc/rc.conf+
# and +/etc/rc.conf.d+, install kernel modules.
class freebsd {
  class { '::freebsd::mounts': } ->
  class { '::freebsd::rcconf': } ->
  class { '::freebsd::kld_list': } ->
  Class['freebsd']

  class { '::freebsd::klds': }
}
