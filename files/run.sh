#!/bin/sh

sudo -H -u znc sh -c 'znc' &
bitlbee -F -u bitlbee
sudo -H -u unrealircd sh -c '/home/unrealircd/unrealircd/bin/unrealircd -F'

