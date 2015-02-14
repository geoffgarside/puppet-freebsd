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

  $_default  = $::freebsd::params::kernel_modules
  $_hiera    = hiera('freebsd::kernel_modules', [])

  if $::cpu_supports_aesni {
    $_aesni  = ['aesni']
  } else {
    $_aesni  = []
  }

  $_modules  = concat($_default, $_hiera, $_aesni)
  $modules   = unique(sort($_modules))

  freebsd::kernel_module { $modules:
    ensure => 'present',
  }
}
