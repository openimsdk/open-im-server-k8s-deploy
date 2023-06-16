#!/usr/bin/env bash

service=(
  #api service file
  api
  #rpc service file
  user
  friend
  group
  auth
  conversation
  third
  msg-gateway
  msg-transfer
  msg
  push
)

for i in ${service[*]}
do
    kubectl -n openim delete deployment "${i}-deployment"
done
echo done