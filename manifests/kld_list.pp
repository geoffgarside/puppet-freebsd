# == Class: freebsd::kld_list
#
# Sets up required items for freebsd::kernel_module
class freebsd::kld_list {
  include freebsd::params

  file { $::freebsd::params::kld_conf_d:
    ensure  => file,
    mode    => '0640',
    owner   => 'root',
    group   => 'wheel',
  }

  exec { $::freebsd::params::restart_kld:
    command     => 'service kld start',
    path        => ['/bin', '/sbin', '/usr/bin', '/usr/sbin'],
    refreshonly => true,
  }
}
