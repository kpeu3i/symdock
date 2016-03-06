# SymDock

A symfony project running on multiple Docker containers. Docker Compose is used for orchestration.

## Dependencies

To use the SymDock, you must install the **latest** [Docker](https://docs.docker.com/engine/installation/) and [Docker Compose](https://docs.docker.com/compose/install/) or [Docker Toolbox](https://www.docker.com/docker-toolbox) on your computer.

#### Activate NFS (OS X only)
    
If you are using OSX, you need to activate NFS for an existing boot2docker box created through Docker Machine.

    $ curl -s https://raw.githubusercontent.com/adlogix/docker-machine-nfs/master/docker-machine-nfs.sh | sudo tee /usr/local/bin/docker-machine-nfs > /dev/null && sudo chmod +x /usr/local/bin/docker-machine-nfs

    $ docker-machine-nfs dev -f --nfs-config="-alldirs -maproot=root"

    $ docker-machine ssh dev df

For more details, see https://github.com/adlogix/docker-machine-nfs    
    
## Installation

1. Clone this repository:

        $ git clone git@github.com:kpeu3i/symdock.git    
    
2. Go to the cloned repository directory and create some extra folders:
    
        $ mkdir -p ./symfony
        $ mkdir -p ./db
        
3. Go to the `docker` folder:
       
        $ cd docker
        
4. Add `config.env` file (just copy `config.env.sample` to the `config.env`)
         
         $ cp ./config.env.sample ./config.env
    
5. Run `build.sh` script:
    
        $ ./build.sh
    
6. Put your Symfony application into `symfony` folder or run `symfony.sh` script to install it:
    
        $ ./symfony.sh

You are done! Your project is available at http://127.0.0.1:8080 (for OS X, check your ip `docker-machine ip dev`). 

Other services:

* phpMyAdmin: http://127.0.0.1:8081/
* RabbitMQ: http://127.0.0.1:15672/
* Elasticsearch: http://127.0.0.1:9200/
* Kibana: http://127.0.0.1:5601/

## Advanced configuration

In the `config.env` file you can define environment variables for a project like:
    
* SYMDOCK_PROJECT_NAME - project name
* SYMDOCK_SYMFONY_VOLUME_PATH - path to Symfony app, will be shared among containers
* SYMDOCK_MYSQL_DB_VOLUME_PATH - path to directory with MySQL dumpfile, will be mounted into mysql container 
* SYMDOCK_MYSQL_DB_FILENAME - MySQL dump filename
* SYMDOCK_SSH_PRIVATE_KEY - private key, will be copied into images
* SYMDOCK_HOST_UID - host user id, will be mapped with www-data uid in containers 
* SYMDOCK_HOST_GID - host group id, will be mapped with www-data gid in containers

After modification, it is needed to rebuild images.

## Useful scripts

Rebuild all Docker images:

    $ ./build.sh

Stop containers:
    
    $ ./stop.sh

Start containers:
    
    $ ./start.sh
    
Check containers status:
    
    $ ./status.sh
    
## Run a command

You can run one-shot command inside any service container, for example:

    $ docker exec -u www-data -it symdock_php_1 composer app/console cache:clear

## Import MySQL dumpfile

If you want to import your database, follow the steps below:
    
1. Put your dumpfile `SYMDOCK_MYSQL_DB_FILENAME` into `SYMDOCK_MYSQL_DB_VOLUME_PATH`

2. Run import command:
    
        $ docker exec -it contentoff_mysql_1 /scripts/mysql/import.sh username password dbname

    
