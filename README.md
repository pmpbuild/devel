
# Plex Media Player build repository

requires: github account, ssh key + 100G disk space to build.

Build PMP in 5 easy steps using docker container as build system.

contains: Dockerfile + build.sh

1. create github.com account

2. clone repo into /root

`git clone https://github.com/pmpbuild/devel.git /root`

3. create ssh key /root/.ssh/id_rsa

`$ ssh-keygen -q -t rsa -f /root/.ssh/id_rsa -N ""`

4. add your public key to github /root/.ssh/id_rsa.pub

5. build PMP and copy files from container to host:/root and remove container again.

`$ sh build.sh`



that's it takes about 6 hours to build using i7 2.93Ghz

thanks to [https://forums.plex.tv/profile/discussions/stedaniels](stedaniels) for build instructions.
