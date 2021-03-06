# == Resource: freebsd::kld
#
# Manage kernel modules
#
# == Parameters:
#
# [*kld*]
#   Name of the kernel module to manage.
#
# [*ensure*]
#   Ensure the state of the kernel module.
#   Default: 'present'.
define freebsd::kld (
  $kld    = $name,
  $ensure = 'present'
) {
  include ::stdlib
  include ::freebsd

  file_line { "kld_list-${kld}":
    ensure => $ensure,
    path   => $::freebsd::params::kld_conf_d,
    line   => "kld_list=\"\$kld_list ${kld}\"\n",
    notify => Exec[$::freebsd::params::restart_kld],
  }
}
