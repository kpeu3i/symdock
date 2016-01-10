# SymDock

A symfony project running on multiple Docker containers. Docker Compose is used for orchestration.
    
# Installation

First, clone this repository:

    $ git clone git@github.com:kpeu3i/symdock.git

Second, go to the `docker` folder:
    
    $ cd docker

Next, run `build.sh` script:
    
    $ ./build.sh
    
Next, put your Symfony application into `symfony` folder or run `install.sh` script:
    
    $ ./install.sh

You are done! Your project is available at http://127.0.0.1:8080 (for OS X, check your ip `docker-machine ip dev`). 

_Note :_ you can rebuild all Docker images by running:

    $ ./build.sh
    
Also you can configure your project name in `project` file.
    
# Running a command

You can run one-shot command inside the `symfony` service container (`symdock` is default project name, value from `project` file):

    docker exec -u www-data -it symdock_symfony_1 composer app/console cache:clear

    
