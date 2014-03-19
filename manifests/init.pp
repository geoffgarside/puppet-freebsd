class freebsd {
  class { '::freebsd::mounts': } ->
  class { '::freebsd::rcconf': } ->
  class { '::freebsd::kld_list': } ->
  Class['freebsd']

  class { '::freebsd::klds': }
}
