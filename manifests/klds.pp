# == Class: freebsd::klds
#
# Manages default kernel modules, installs kernel
# modules defined in +freebsd::kernel_modules+
# hiera key.
#
# Installs the aesni kernel module if the AESNI
# CPU feature is detected.
class freebsd::klds {
  require stdlib
  include freebsd::params

  if $::cpu_supports_aesni {
    $_default = concat($::freebsd::params::kernel_modules, 'aesni')
  } else {
    $_default = $::freebsd::params::kernel_modules
  }

  $_hiera    = hiera('freebsd::kernel_modules', [])
  $_modules  = concat($_default, $_hiera)
  $modules   = unique(sort($_modules))

  freebsd::kernel_module { $modules:
    ensure => 'present',
  }
}
