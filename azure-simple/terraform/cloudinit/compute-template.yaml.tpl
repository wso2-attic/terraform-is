#cloud-config

mounts:
 - [ "//isstorageshare.file.core.windows.net/isshare", /mnt/sharedfs, "cifs", "vers=3.0,username=isstorageshare,password=${storage_access_key},dir_mode=0777,file_mode=0777,serverino", "0", "0"]

runcmd:
 - sed -i 's|CONNECTION_STRING|${db_connection_strings}|g' /tmp/ansible-is/dev/group_vars/is.yml
 - cd /tmp/ansible-is && ansible-playbook -i dev/inventory site.yml
