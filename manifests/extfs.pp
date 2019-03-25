define tune2fs::extfs (
                        $dev                   = $name,
                        $max_mount_count       = '-1',
                        $reserved_blocks       = '0',
                        $reserved_blocks_user  = 'root',
                        $reserved_blocks_group = 'root',
                        $check_interval        = '0',
                      ) {
  include ::tune2fs

  Exec {
    path => '/bin:/sbin:/usr/bin:/usr/sbin',
  }

  exec { "max_mount_count ${dev}":
    command => "tune2fs -c ${max_mount_count} ${dev}",
    unless  => "tune2fs -l ${dev} | grep 'Maximum mount count' | awk '{ print \$NF }' | grep '^${max_mount_count}$'",
    require => Class['::tune2fs'],
  }

  exec { "reserved_blocks_user ${dev}":
    command => "tune2fs -u ${reserved_blocks_user} ${dev}",
    unless  => "tune2fs -l ${dev} | grep 'Reserved blocks uid' | grep '${reserved_blocks_user}'",
    require => Class['::tune2fs'],
  }

  exec { "reserved_blocks_group ${dev}":
    command => "tune2fs -g ${reserved_blocks_group} ${dev}",
    unless  => "tune2fs -l ${dev} | grep 'Reserved blocks gid' | grep '${reserved_blocks_group}'",
    require => Class['::tune2fs'],
  }

  if $reserved_blocks =~ /^ *(\d+) *% *$/
  {
    $reserved_blocks_percent=$1

    validate_integer($reserved_blocks_percent)

    exec { "reserved_blocks ${dev}":
      command => "bash -c 'tune2fs -r \"$(($(($(tune2fs -l ${dev} | grep '\"'\"'Block count'\"'\"' | awk '\"'\"'{ print \$NF }'\"'\"')/100))*${reserved_blocks_percent}))\" ${dev}'",
      unless  => "bash -c 'tune2fs -l ${dev} | grep '\"'\"'Reserved block count'\"'\"' | awk '\"'\"'{ print \$NF }'\"'\"' | grep -E \"^$(($(($(tune2fs -l ${dev} | grep '\"'\"'Block count'\"'\"' | awk '\"'\"'{ print \$NF }'\"'\"')/100))*${reserved_blocks_percent}))$\"'",
      require => Class['::tune2fs'],
    }
  }
  else
  {
    validate_integer($reserved_blocks)

    exec { "reserved_blocks ${dev}":
      command => "tune2fs -r ${reserved_blocks} ${dev}",
      unless  => "tune2fs -l ${dev} | grep 'Reserved block count' | awk '{ print \$NF }' | grep -E '^${reserved_blocks}$'",
      require => Class['::tune2fs'],
    }
  }

  validate_integer($check_interval)

  exec { "check_interval ${dev}":
    command => "tune2fs -i ${check_interval}s ${dev}",
    unless  => "tune2fs -l ${dev} | grep 'Check interval' | awk '{ print \$3 }' | grep -E '^${check_interval}$'",
    require => Class['::tune2fs'],
  }

}
