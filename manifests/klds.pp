# == Class: freebsd::klds
#
# Manages default kernel modules, installs kernel
# modules defined in +freebsd::kernel_modules+
# hiera key.
class freebsd::klds {
  require stdlib
  include freebsd::params

  $default_modules  = $::freebsd::params::kernel_modules
  $hiera_modules    = hiera('freebsd::kernel_modules', [])
  $all_modules      = concat($default_modules, $hiera_modules)

  freebsd::kernel_module { $all_modules:
    ensure => 'present',
  }
}
