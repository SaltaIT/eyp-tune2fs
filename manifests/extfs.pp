define tune2fs::extfs (
                        $dev=$name,
                        $max_mount_count='-1',
                        $reserved_blocks_count='0',
                        $reserved_blocks_user='root',
                        $reserved_blocks_group='root',
                        $check_interval='0',
                      ) {

  Exec {
    path => '/bin:/sbin:/usr/bin:/usr/sbin',
  }

  exec { "max_mount_count ${dev}":
    command => "tune2fs -c ${max_mount_count} ${dev}",
    unless  => "tune2fs -l ${dev} | grep 'Maximum mount count' | awk '{ print \$NF }' | grep '^${max_mount_count}$'",
  }

  exec { "reserved_blocks_count ${dev}":
    command => "tune2fs -r ${reserved_blocks_count} ${dev}",
    unless  => "tune2fs -l ${dev} | grep 'Reserved block count' | awk '{ print \$NF }' | grep -E '^${reserved_blocks_count}$'",
  }

  exec { "reserved_blocks_user ${dev}":
    command => "tune2fs -u ${reserved_blocks_user} ${dev}",
    unless  => "tune2fs -l ${dev} | grep 'Reserved blocks uid' | grep '${reserved_blocks_user}'",
  }

  exec { "reserved_blocks_group ${dev}":
    command => "tune2fs -g ${reserved_blocks_group} ${dev}",
    unless  => "tune2fs -l ${dev} | grep 'Reserved blocks gid' | grep '${reserved_blocks_group}'",
  }

  exec { "check_interval ${dev}":
    command => "tune2fs -i ${check_interval}s ${dev}",
    unless  => "tune2fs -l ${dev} | grep 'Check interval' | awk '{ print \$3 }' | grep -E '^${check_interval}$'",
  }

}
