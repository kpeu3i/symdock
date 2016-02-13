# SymDock

A symfony project running on multiple Docker containers. Docker Compose is used for orchestration.

## Requirements

To use the SymDock, you must install **latest** [Docker](https://docs.docker.com/engine/installation/) and [Docker Compose](https://docs.docker.com/compose/install/) or [Docker Toolbox](https://www.docker.com/docker-toolbox) on your computer.
    
## Installation

1. Clone this repository:

        $ git clone git@github.com:kpeu3i/symdock.git    
    
2. Set your project name in the `project` file.
    
3. Go to the `docker` folder:
    
        $ cd docker

4. Run `build.sh` script:
    
        $ ./build.sh
    
5. Put your Symfony application into `symfony` folder or run `symfony.sh` script:
    
        $ ./symfony.sh

You are done! Your project is available at http://127.0.0.1:8080 (for OS X, check your ip `docker-machine ip dev`). 

_Note:_ you can rebuild all Docker images by running:

    $ ./build.sh

Stop containers:
    
    $ ./stop.sh

Start containers:
    
    $ ./start.sh
    
## Running a command

You can run one-shot command inside the `symfony` service container (replace the prefix `symdock` in container name `symdock_symfony_1` with the actual project name):

    docker exec -u www-data -it symdock_symfony_1 composer app/console cache:clear

    
