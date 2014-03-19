class freebsd::klds {
  require stdlib

  $default_modules  = $::freebsd::params::kernel_modules
  $hiera_modules    = hiera('freebsd::kernel_modules', [])
  $all_modules      = concat($default_modules, $hiera_modules)

  freebsd::kernel_module { $all_modules:
    ensure => 'present',
  }
}
