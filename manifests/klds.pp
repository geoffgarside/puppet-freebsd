# == Class: freebsd::klds
#
# Manages default kernel modules, installs kernel
# modules defined in +freebsd::kernel_modules+
# hiera key.
#
# Installs the aesni kernel module if the AESNI
# CPU feature is detected.
#
# === Examples
#
#  include freebsd::klds
#
# === Authors
#
# Geoff Garside <puppet@geoffgarside.co.uk>
#
# === Copyright
#
# Copyright 2014 Geoff Garside, unless otherwise noted.
#
class freebsd::klds {
  include ::stdlib
  include ::freebsd::params

  if $::cpu_supports_aesni {
    $_default = concat($::freebsd::params::kernel_modules, 'aesni')
  } else {
    $_default = $::freebsd::params::kernel_modules
  }

  $_hiera    = hiera_array('freebsd::kernel_modules', [])
  $_modules  = concat($_default, $_hiera)
  $modules   = unique(sort($_modules))

  freebsd::kernel_module { $modules:
    ensure => 'present',
  }
}
