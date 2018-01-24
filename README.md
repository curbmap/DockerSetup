# DockerSetup
Docker Setup configuration

# This repository is set up to autobuild on hub.docker.com. 
### To get the prebuilt image:
- ```docker pull curbmap/testing:latest```
- Run an interactive shell
    - ```docker run -i -e "container=docker" -v /sys/fs/cgroup:/sys/fs/cgroup:ro -p 127.0.0.1:8081:8081 -p 127.0.0.1:8080:8080 -t curbmap/testing:latest /bin/bash```

### To build this repository:
- Clone this repository
- ```cd DockerSetup```
- ```docker build -t testing .```
- ```docker run -i -e "container=docker" -v /sys/fs/cgroup:/sys/fs/cgroup:ro -p 127.0.0.1:8081:8081 -p 127.0.0.1:8080:8080 -t testing:latest /bin/bash```

### Interactive shells
Right now all work needs to be done interactively in shells (that is, you can't run ```/services/startscript.sh``` from ```docker run``` because it runs the processes in the background). From inside the interactive shell you can run:
- /services/downloaddata.sh
- /services/startscript.sh
- /services/updaterepos.sh

You can save changes to the state of the machine using ```docker commit <CONTAINER ID from docker ps> <new tag for the container>```. Then you can run that container tag instead of testing:latest or curbmap/testing:latest.
