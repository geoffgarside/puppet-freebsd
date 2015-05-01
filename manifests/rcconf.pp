# == Class: freebsd::rcconf
#
# Manages permissions on /etc/rc.conf file and
# the /etc/rc.conf.d directory.
#
# === Examples
#
#  include freebsd::rcconf
#
# === Authors
#
# Geoff Garside <puppet@geoffgarside.co.uk>
#
# === Copyright
#
# Copyright 2014 Geoff Garside, unless otherwise noted.
#
class freebsd::rcconf {
  include freebsd::params

  file { $::freebsd::params::rc_conf:
    ensure  => 'file',
    replace => false,
    owner   => 'root',
    group   => 'wheel',
    mode    => '0640',
  }

  file { $::freebsd::params::rc_conf_d:
    ensure => 'directory',
    mode   => '0755',
    owner  => 'root',
    group  => 'wheel',
  }
}
