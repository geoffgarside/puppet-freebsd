# == Class: freebsd::params
class freebsd::params {
  $mount_dev_fd = '/dev/fd'
  $mount_proc   = '/proc'

  $rc_conf      = '/etc/rc.conf'
  $rc_conf_d    = '/etc/rc.conf.d'

  $kld_conf_d   = "${rc_conf_d}/kld"
  $restart_kld  = 'refresh kld'

  $kernel_modules = [
    'aesni',
    'coretemp',
  ]
}
