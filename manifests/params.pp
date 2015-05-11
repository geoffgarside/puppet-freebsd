# == Class: freebsd::params
class freebsd::params {
  # Mountpoints
  $dev_fd            = '/dev/fd'
  $proc              = '/proc'
  $compat            = '/compat'
  $usr_compat        = '/usr/compat'
  $compat_linux      = "${usr_compat}/linux"
  $compat_linux_proc = "${compat_linux}/proc"

  # Config file/directory paths
  $rc_conf     = '/etc/rc.conf'
  $rc_conf_d   = '/etc/rc.conf.d'
  $kld_conf_d  = "${rc_conf_d}/kld"
  $sysctl_conf = '/etc/sysctl.conf'

  # Notify Exec Names
  $restart_kld  = 'refresh kld'
  $restart_sysctl = 'reload sysctl'
  $netif_cloneup  = 'netif cloneup'

  # Init Parameters
  $mount_devfd     = true
  $mount_procfs    = true
  $mount_linprocfs = false
  $kernel_modules  = ['coretemp']
  $sysctls         = {}
}
