# == Class: freebsd::mounts
#
# Mounts +/dev/fd+ and +/proc+ file systems.
#
# === Examples
#
#  include freebsd::mounts
#
# === Authors
#
# Geoff Garside <puppet@geoffgarside.co.uk>
#
# === Copyright
#
# Copyright 2014 Geoff Garside, unless otherwise noted.
#
class freebsd::mounts {
  include ::freebsd

  $mount_devfd = $::freebsd::mount_devfd ? {
    true    => 'mounted',
    default => 'absent',
  }

  $mount_procfs = $::freebsd::mount_procfs ? {
    true    => 'mounted',
    default => 'absent',
  }

  mount { $::freebsd::params::dev_fd:
    ensure   => $mount_devfd,
    device   => 'fdescfs',
    fstype   => 'fdescfs',
    options  => 'rw,late',
    dump     => '0',
    pass     => '0',
    remounts => true,
  }

  mount { $::freebsd::params::proc:
    ensure   => $mount_procfs ,
    device   => 'proc',
    fstype   => 'procfs',
    options  => 'rw,late',
    dump     => '0',
    pass     => '0',
    remounts => true,
  }
}
