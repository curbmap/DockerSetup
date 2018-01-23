if [ ! -f /etc/sysconfig/network ]; then 
  touch /etc/sysconfig/network
fi
echo NETWORKING=yes >> /etc/sysconfig/network