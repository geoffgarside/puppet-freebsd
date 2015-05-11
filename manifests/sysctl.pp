# == Resource: freebsd::sysctl
#
# Manage sysctl properties.
#
# == Parameters:
#
# [*sysctl*]
#   Name of the sysctl to manage
#
# [*value*]
#   Value of the sysctl
#
# [*ensure*]
#   Whether to set 'present' or delete 'absent' the sysctl key.
#
# === Authors
#
# Geoff Garside <puppet@geoffgarside.co.uk>
#
# === Copyright
#
# Copyright 2014 Geoff Garside, unless otherwise noted.
#
define freebsd::sysctl (
  $value,
  $sysctl = $name,
  $ensure = 'present',
) {
  if !defined(File[$::freebsd::params::sysctl_conf]) {
    file { $::freebsd::params::sysctl_conf:
      ensure => 'file',
      owner  => 'root',
      group  => '0',
      mode   => '0644',
    }
  }

  if !defined(Exec[$::freebsd::params::restart_sysctl]) {
    exec { $::freebsd::params::restart_sysctl:
      command     => 'service sysctl reload',
      path        => ['/bin', '/sbin', '/usr/bin', '/usr/sbin'],
      refreshonly => true,
    }
  }

  if $ensure == 'present' {
    $changes = "set ${sysctl} ${value}"
  } else {
    $changes = "rm ${sysctl}"
  }

  augeas { "sysctl: ${sysctl} = ${value}":
    incl    => $::freebsd::params::sysctl_conf,
    lens    => 'Sysctl.lns',
    changes => $changes,
    require => File[$::freebsd::params::sysctl_conf],
    notify  => Exec[$::freebsd::params::restart_sysctl],
  }
}
