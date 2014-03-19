class freebsd::rcconf {

  file { $::freebsd::params::rc_conf:
    ensure  => 'file',
    replace => false,
    owner   => 'root',
    group   => 'wheel',
    mode    => '0640',
  }

  file { $::freebsd::params::rc_conf_d:
    ensure => 'directory',
    mode   => '0755',
    owner  => 'root',
    group  => 'wheel',
  }
}
