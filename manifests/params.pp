class freebsd::params {
  $mount_dev_fd = '/dev/fd'
  $mount_proc   = '/proc'

  $rc_conf      = '/etc/rc.conf'
  $rc_conf_d    = '/etc/rc.conf.d'

  $kld_list     = "${rc_conf_d}/kld_list"
  $kld_conf_d   = "${rc_conf_d}/kld"
  $restart_kld  = 'refresh kld'

  $kernel_modules = [
    'aesni',
    'accf_http',
    'accf_data',
    'accf_dns',
    'aio',
    'cc_htcp',
    'coretemp',
  ]
}
