# == Resource: freebsd::rc_conf
#
# Manage variables in /etc/rc.conf
#
# == Parameters:
#
# [*ensure*]
#   Ensure presence or absence of the variable.
#   Default 'present'.
#
# [*key*]
#   Variable name.
#
# [*value*]
#   Variable value.
#   Booleans, yes/no, on/off are converted to YES/NO.
#   Arrays are joined by spaces.
define freebsd::rc_conf (
  $ensure = 'present',
  $key    = $title,
  $value  = [],
) {
  include ::freebsd

  $rc_conf = $::freebsd::params::rc_conf

  Augeas {
    incl    => $rc_conf,
    lens    => 'Shellvars.lns',
    require => File[$rc_conf],
  }

  case $value {
    true, 'yes', 'YES', 'on', 'ON': {
      $_value = 'YES'
    }
    false, 'no', 'NO', 'off', 'OFF': {
      $_value = 'NO'
    }
    default: {
      if is_array($value) {
        $_value = join($value, ' ')
      } else {
        $_value = $value
      }
    }
  }

  case $ensure {
    'absent': {
      augeas { "${rc_conf}: '${name}' removed":
        changes => "rm ${name}",
      }
    }
    default: {
      case $_value {
        undef, '': {
          augeas { "${rc_conf}: '${name}' removed":
            changes => "rm ${name}",
          }
        }
        default: {
          augeas { "${rc_conf}: '${name}' = '${_value}'":
            changes => "set ${name} '\"${_value}\"'",
          }
        }
      }
    }
  }
}
