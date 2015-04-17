#!/bin/bash

# launch the mean docker container to execute a single command on the working directory
# the working directory will be mounted as /working in the docker container


# test if the data-docker-home container has been created
if docker inspect -f {{.Name}} data-docker-home > /dev/null
  then 
    echo > /dev/null
  else
    echo "* creating data-docker-home container"
    echo
    # The data container has a volume at /home/docker, is named 'data' and is based on busybox
    docker create -v /home/docker --name data-docker-home adamarthurryan/mean echo "Data container - docker home"
    
fi

docker/start-mongodb

docker run -it --rm --link mongodb:mongodb --volumes-from=data-docker-home -v ${PWD}:/working -w /working -p 9000:9000 -p 35729:35729 adamarthurryan/mean grunt serve
