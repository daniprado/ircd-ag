#!/bin/sh

edit_cfg=0

# get rid of file permissions (just in case)
chown -R unrealircd: /home/unrealircd
chown -R bitlbee: /etc/bitlbee
chown -R bitlbee: /var/lib/bitlbee
chown -R znc: /var/lib/znc

# generate ZNC's config
if [ ! -f "/var/lib/znc/.znc/configs/znc.conf" ]; then
    sudo -H -u znc sh -c "znc --makeconf < /etc/znc.defaults"
    edit_cfg=1
fi 

# generate UnrealIRCd's config
if [ ! -f "/home/unrealircd/unrealircd/conf/unrealircd.conf" ]; then
    sudo -H -u unrealircd sh -c 'cp -Rf /home/unrealircd/unrealircd/conf.bk/* /home/unrealircd/unrealircd/conf'
    sudo -H -u unrealircd sh -c 'cp /home/unrealircd/unrealircd/conf/examples/example.conf /home/unrealircd/unrealircd/conf/unrealircd.conf'
    edit_cfg=1
fi

# generate Bitlbee's config
if [ ! -f "/etc/bitlbee/bitlbee.conf" ]; then
    sh -c 'cp -Rf /etc/bitlbee.bk/* /etc/bitlbee'
    sh -c 'cp -Rf /var/lib/bitlbee.bk/* /var/lib/bitlbee'
    edit_cfg=1
fi
    
if [ $edit_cfg == 1 ]; then
    
    echo ----------------------------------------------------------------------
    echo CONFIG FILES HAVE BEEN CREATED... YOU SHOULD REVIEW/EDIT THEM MANUALLY
    echo ----------------------------------------------------------------------
    exit 0

else 
    exec "$@"
fi

