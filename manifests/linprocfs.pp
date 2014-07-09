class freebsd::linprocfs {
  file { '/compat':
    ensure => 'link',
    target => 'usr/compat',
    owner  => 'root',
    group  => 'wheel',
  } ->
  file { '/usr/compat':
    ensure => 'directory',
    mode   => '0755',
    owner  => 'root',
    group  => 'wheel',
  } ->
  file { '/usr/compat/linux':
    ensure => 'directory',
    mode   => '0755',
    owner  => 'root',
    group  => 'wheel',
  } ->
  file { '/usr/compat/linux/proc':
    ensure  => 'directory',
    mode    => '0555',
    owner   => 'root',
    group   => 'wheel',
  } ->
  mount { '/usr/compat/linux/proc':
    ensure   => 'mounted',
    device   => 'linproc',
    fstype   => 'linprocfs',
    options  => 'rw,late',
    dump     => '0',
    pass     => '0',
    remounts => true,
  }
}
