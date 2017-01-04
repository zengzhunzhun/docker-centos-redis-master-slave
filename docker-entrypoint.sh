#!/bin/bash
set -e
master_conf () {
	if [[ ${ROLE} == "master" ]];then
           sed -i 's/bind 127.0.0.1/bind 0.0.0.0/g' /etc/redis.conf
	fi

        /usr/bin/redis-server /etc/redis.conf
}

slave_conf () {
        if [[ ${ROLE} == "slave" ]];then
           sed -i 's/bind 127.0.0.1/bind 0.0.0.0/g' /etc/redis.conf
           sed -i 's/slave-read-only yes/slave-read-only no/g' /etc/redis.conf
           if [ -z ${MASTER_IP} ] || [ -z ${MASTER_PORT} ];then
              echo "###### You must set master_ip and master_port the variable ######"
              exit 0
           else
              sed -i 's/# slaveof <masterip> <masterport>/slaveof '${MASTER_IP}' '${MASTER_PORT}'/g' /etc/redis.conf
           fi
        fi
           
        /usr/bin/redis-server /etc/redis.conf
}

if [[ ${ROLE} == "master" ]]; then
	echo "########### Starting Redis master configuration ############"
	     master_conf
elif [[ ${ROLE} == "slave" ]]; then
        echo "########### Starting Redis slave configuration ############"
	     slave_conf
else
     echo "######## Failed, you must set the role variable and set the correct value #########"
fi
