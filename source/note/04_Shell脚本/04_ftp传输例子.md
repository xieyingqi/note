# ftp传输固件

通过ftp命令，将固件传到开发板上

```bash
#!/bin/bash

ftp -n<<!
open 192.168.2.35
user root wwyc5166
binary
cd /usr/app_install/collect/bin/
lcd /home/ggd/srv/xyq/SmartRQC2100-III/19023_ZKZJ/.build/
put rqc_d_xyq_v20201126 rqc_d_xyq_v20201126
chmod 777 rqc_d_xyq_v20201126
close
bye
!
echo "success"
```