define freebsd::kernel_module (
  $kld    = $title,
  $ensure = 'present'
) {
  require stdlib
  include freebsd

  file_line { "kld_list-${kld}":
    ensure  => $ensure,
    path    => $::freebsd::params::kld_conf_d,
    line    => "kld_list=\"\$kld_list ${kld}\"\n",
    notify  => Exec[$::freebsd::params::restart_kld],
  }
}
