#!/bin/bash
time docker build --no-cache -t ubuntu .
docker run --rm -iv${PWD}:/root ubuntu sh -s <<EOF
chown $(id -u):$(id -g) *
cp -rav /pmp/target/* /root
EOF
