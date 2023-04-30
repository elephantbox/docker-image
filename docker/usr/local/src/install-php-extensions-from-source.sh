#!/bin/bash

##
## DIO
##
cd /usr/local/src
curl -L https://github.com/php/pecl-system-dio/archive/refs/tags/dio-0.2.1.zip --output pecl-system-dio-dio-0.2.1.zip
unzip pecl-system-dio-dio-0.2.1.zip
cd pecl-system-dio-dio-0.2.1
phpize && ./configure && make -j $(nproc) && make install

# cleanup
rm -Rf /usr/local/src/pecl-system-dio-dio-0.2.1*
