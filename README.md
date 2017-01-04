# docker-centos-redis-master-slave
本地下载然后通过dockerfile构建镜像

		git clone https://github.com/zengzhunzhun/docker-centos-redis-master-slave.git 
		docker build -t zengzhunzhun/centos-redis-master-slave:3.2.6 . 
    
通过docker仓库获取镜像

		docker pull zengzhunzhun/centos-redis-master-slave:3.2.6 
设置master的角色、IP地址、端口
		
		export role=master 
		export master_ip=192.168.9.11 
		export master_port=6379  
		export container_port=6379 
启动master的命令

		docker run -d -it --name redis-master \ 
		-p ${master_ip}:${master_port}:${container_port} \ 
		-e ROLE=$role \   
		zengzhunzhun/centos-redis-master-slave:3.2.6
设置slave的角色、IP地址、端口及master的IP地址和端口

    export role=slave
    export slave_ip=192.168.9.12
    export slave_port=6379
    export container_port=6379
    export master_ip=192.168.9.11
    export master_port=6379
启动第一个slave的命令(依此类推启动第二、第三个slave)

    docker run -d -it --name redis-slave1 \
    -p ${slave_ip}:${slave_port}:${container_port} \
    -e ROLE=$role \
    -e MASTER_IP=${master_ip} -e MASTER_PORT=${master_port} \
    zengzhunzhun/centos-redis-master-slave:3.2.6
