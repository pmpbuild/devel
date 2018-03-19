# devel
Plex Media Player build repository

requires: github account, ssh key + 100G disk space to build.

Build PMP in 4 easy steps using docker.

1. create github.com account

2. create ssh key /root/.ssh/id_rsa
~~~
$ ssh-keygen -q -t rsa -f /root/.ssh/id_rsa -N ""
~~~
2. add your public key to github /root/.ssh/id_rsa.pub

3. build PMP and copy files from container to /root 
~~~
$ sh build.sh
~~~
