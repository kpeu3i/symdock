# SymDock

A symfony project running on multiple Docker containers. Docker Compose is used for orchestration.

## Dependencies

To use the SymDock, you must install the **latest** version of [Docker](https://docs.docker.com/engine/installation/) and [Docker Compose](https://docs.docker.com/compose/install/) or [Docker Toolbox](https://www.docker.com/docker-toolbox) on your computer.

#### Activate NFS (OS X only)
    
If you are using OSX, you need to activate NFS for an existing boot2docker box created through Docker Machine.

    $ curl -s https://raw.githubusercontent.com/adlogix/docker-machine-nfs/master/docker-machine-nfs.sh | sudo tee /usr/local/bin/docker-machine-nfs > /dev/null && sudo chmod +x /usr/local/bin/docker-machine-nfs

    $ docker-machine-nfs dev -f --nfs-config="-alldirs -maproot=root"

    $ docker-machine ssh dev df

For more details, see https://github.com/adlogix/docker-machine-nfs    
    
## Installation

1. Clone this repository:

        $ git clone git@github.com:kpeu3i/symdock.git ~/symdock

2. Go to the cloned folder:
       
        $ cd ~/symdock 
           
3. Run:
       
        $ make init
        
You are done! Fresh Symfony application is available at http://127.0.0.1:8080 (for OS X, check your ip `docker-machine ip dev`). 

Other services:

* RabbitMQ: http://127.0.0.1:15672/
* Elasticsearch: http://127.0.0.1:9200/
* Kibana: http://127.0.0.1:5601/
* PhpMyAdmin (only in dev): http://127.0.0.1:8081/

## Advanced configuration

You can adapt `.env` file to your needs:

* COMPOSE_PROJECT_NAME - project name
* SYMDOCK_SYMFONY_VOLUME_PATH - absolute path to Symfony directory to share your code among containers (only in dev)
* SYMDOCK_PRIVATE_KEY_FILENAME - absolute path to ssh private key to access a private repositories from containers (optional)
* SYMDOCK_HOST_UID - host uid to map it with "www-data" uid in containers (only in dev)
* SYMDOCK_HOST_GID - host guid to map it with "www-data" gid in containers (only in dev)
* SYMDOCK_SYMFONY_REPOSITORY - ssh or https url to git repository with a Symfony application
* SYMDOCK_SYMFONY_REPOSITORY_BRANCH - custom git branch (optional)
* SYMDOCK_COMPOSER_CONTAINER - container to run composer commands 
* SYMDOCK_NGINX_PORT - Nginx port
* SYMDOCK_MYSQL_PORT - MySql port
* SYMDOCK_RABBITMQ_NODE_PORT - RabbitMQ port
* SYMDOCK_RABBITMQ_MANAGER_PORT - RabbitMQ web-admin port
* SYMDOCK_ELASTICSEARCH_API_PORT - Elasticsearch web-api port
* SYMDOCK_ELASTICSEARCH_SERVICE_PORT - Elasticsearch TCP transport port
* SYMDOCK_ELASTICSEARCH_LOGS_API_PORT - Elasticsearch (logs) api port
* SYMDOCK_ELASTICSEARCH_LOGS_SERVICE_PORT - Elasticsearch (logs) TCP transport port
* SYMDOCK_PHPMYADMIN_PORT - PhpMyAdmin web-admin port
* SYMDOCK_KIBANA_PORT - Kibana web-admin port
* SYMDOCK_FLUENTD_PORT - Fluentd port

## Useful scripts

Build all Docker images:

    $ make build

Force rebuild all Docker images:

    $ make rebuild

Check containers status:
    
    $ make status

Stop containers:
    
    $ make stop

Start containers:
    
    $ make start
    
Start containers:
    
    $ make restart

Install composer packages:

    $ make composer-install
    
Update composer packages:

    $ make composer-update
    
## Run a command

You can run one-shot command inside any container, for example:

    $ docker-compose exec --user www-data php app/console cache:clear
    
