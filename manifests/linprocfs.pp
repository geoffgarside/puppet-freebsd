# == Class: freebsd::linprocfs
#
# Configures the linux /proc file system.
class freebsd::linprocfs {
  include ::freebsd::params

  if $::virtual == 'jail' {
    $mount_linprocfs = false
  } else {
    $mount_linprocfs = $::freebsd::mount_linprocfs
  }

  if $mount_linprocfs {
    $link_ensure  = 'link'
    $dir_ensure   = 'directory'
    $mount_ensure = 'mounted'

    File[$::freebsd::params::compat] ->
    File[$::freebsd::params::usr_compat] ->
    File[$::freebsd::params::compat_linux] ->
    File[$::freebsd::params::compat_linux_proc] ->
    Mount[$::freebsd::params::compat_linux_proc]
  } else {
    $link_ensure  = 'absent'
    $dir_ensure   = 'absent'
    $mount_ensure = 'absent'

    Mount[$::freebsd::params::compat_linux_proc] ->
    File[$::freebsd::params::compat_linux_proc] ->
    File[$::freebsd::params::compat_linux] ->
    File[$::freebsd::params::usr_compat] ->
    File[$::freebsd::params::compat]
  }

  file { $::freebsd::params::compat:
    ensure => $link_ensure,
    target => regsubst($::freebsd::params::usr_compat, '^(/)', ''),
    owner  => 'root',
    group  => 'wheel',
  }

  file { $::freebsd::params::usr_compat:
    ensure => $dir_ensure,
    mode   => '0755',
    owner  => 'root',
    group  => 'wheel',
  }

  file { $::freebsd::params::compat_linux:
    ensure => $dir_ensure,
    mode   => '0755',
    owner  => 'root',
    group  => 'wheel',
  }

  file { $::freebsd::params::compat_linux_proc:
    ensure => $dir_ensure,
    mode   => '0555',
    owner  => 'root',
    group  => 'wheel',
  }

  mount { $::freebsd::params::compat_linux_proc:
    ensure   => $mount_ensure,
    device   => 'linproc',
    fstype   => 'linprocfs',
    options  => 'rw,late',
    dump     => '0',
    pass     => '0',
    remounts => true,
  }
}
