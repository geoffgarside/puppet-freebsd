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
  include ::freebsd::params

  mount { $::freebsd::params::mount_dev_fd:
    ensure   => 'mounted',
    device   => 'fdescfs',
    fstype   => 'fdescfs',
    options  => 'rw,late',
    dump     => '0',
    pass     => '0',
    remounts => true,
  }

  mount { $::freebsd::params::mount_proc:
    ensure   => 'mounted',
    device   => 'proc',
    fstype   => 'procfs',
    options  => 'rw,late',
    dump     => '0',
    pass     => '0',
    remounts => true,
  }
}
