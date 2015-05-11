# == Class: freebsd
#
# Management and configuration of low level FreeBSD components.
#
# This module will setup the +/dev/fd+ and +/proc+ filesystems,
# manages permissions of +/etc/rc.conf+ and +/etc/rc.conf.d+,
# install kernel modules.
#
# Installs the aesni kernel module if the AESNI
# CPU feature is detected.
#
# === Examples
#
#  include freebsd
#
# === Parameters
#
# [*mount_devfd*]
#   Enable /dev/fd mountpoint
#
# [*mount_procfs*]
#   Enable /proc mountpoint
#
# [*mount_linprocfs*]
#   Enable /compat/linux/proc mountpoint
#
# [*kernel_modules*]
#   Array of kernel modules to load
#
# [*sysctls*]
#   Hash of sysctl to set.
#
# === Authors
#
# Geoff Garside <puppet@geoffgarside.co.uk>
#
# === Copyright
#
# Copyright 2014 Geoff Garside, unless otherwise noted.
#
class freebsd (
  $mount_devfd     = $::freebsd::params::mount_devfd,
  $mount_procfs    = $::freebsd::params::mount_procfs,
  $mount_linprocfs = $::freebsd::params::mount_linprocfs,
  $kernel_modules  = $::freebsd::params::kernel_modules,
  $sysctls         = $::freebsd::params::sysctls,
) inherits freebsd::params {

  if $::cpu_supports_aesni {
    $real_kernel_modules = unique(sort(concat($kernel_modules, 'aesni')))
  } else {
    $real_kernel_modules = unique(sort($kernel_modules))
  }

  anchor { 'freebsd::begin': }->
  class { '::freebsd::rcconf': } ->
  class { '::freebsd::kld_list': } ->
  class { '::freebsd::mounts': } ->
  anchor { 'freebsd::end': }

  freebsd::kld { $real_kernel_modules:
    ensure => 'present',
  } -> Anchor['freebsd::end']

  Freebsd::Sysctl {
    before => Anchor['freebsd::end']
  }

  create_resources('freebsd::sysctl', $sysctls)
}
