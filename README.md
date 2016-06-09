# tune2fs

![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)

#### Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup](#setup)
    * [What tune2fs affects](#what-tune2fs-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with tune2fs](#beginning-with-tune2fs)
4. [Usage](#usage)
5. [Reference](#reference)
5. [Limitations](#limitations)
6. [Development](#development)
    * [Contributing](#contributing)

## Overview

manages tune2fs attributes on a extfs

## Module Description

TODO

## Setup

### What tune2fs affects

TODO

### Setup Requirements

This module requires pluginsync enabled

### Beginning with tune2fs

```puppet
tune2fs::extfs { '/dev/mapper/vg0-root':
  max_mount_count=>'30',
  reserved_blocks=> '0',
}
```

```puppet
tune2fs::extfs { '/dev/mapper/vg0-root':
  max_mount_count=>'30',
  reserved_blocks=> '20%',
}
```

## Usage

### define tune2fs::extfs
* **dev**: device to apply settings (defaults to resource's name)
* **max_mount_count**: Adjust the number of mounts after which the filesystem will be checked (defaults to '-1')
* **reserved_blocks**: Set the number of reserved filesystem blocks, can also be set as a percentage (defaults to '0')
* **reserved_blocks_user**: Set  the user who can use the reserved filesystem blocks (defaults to 'root')
* **reserved_blocks_group**: Set  the  group  which  can  use the reserved filesystem blocks (defaults to 'root')
* **check_interval**: Adjust the maximal time between two filesystem checks (defaults to '0')

## Reference

### class tune2fs
validates tune2fs presence

### define tune2fs::extfs
manages extfs settings

### fact eyp_tune2fs_check_tune2fs
tune2fs full path - used to check it's presence

## Limitations

TODO

## Development

We are pushing to have acceptance testing in place, so any new feature should
have some test to check both presence and absence of any feature

### Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
