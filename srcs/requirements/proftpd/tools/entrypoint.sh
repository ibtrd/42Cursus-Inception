#!/bin/sh

echo "www-data:truc" | chpasswd
exec $@
