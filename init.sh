#!/bin/bash
##Update packages
apt update && apt upgrade -y

apt -qy install \
    qt5-default qt5-qmake qtbase5-dev-tools qttools5-dev-tools \
    build-essential libboost-dev libboost-system-dev \
    libboost-filesystem-dev libboost-program-options-dev libboost-thread-dev \
    libssl-dev git libminiupnpc-dev libzmq3-dev \
    software-properties-common python-software-properties

add-apt-repository -y ppa:bitcoin/bitcoin
apt update
apt -qy install libdb4.8-dev libdb4.8++-dev

##Check if binaries are already installed
if [ ! -f ~/quarkcoin-bin/bin/quarkd ]; then
    cd ~
    ##Rename folder appropriately
    mv quarkcoin-0.10.6.3 quarkcoin-bin
    ##Add quarkd commands to PATH
    echo 'export PATH=$PATH:~/quarkcoin-bin/bin/' > ~/.bashrc
    source ~/.bashrc 
fi

##Check if configuration file exists
if [ ! -f ~/.quarkcoin/quarkcoin.conf ]; then
    mkdir ~/.quarkcoin
    echo rpcuser=quarkcoinrpc > ~/.quarkcoin/quarkcoin.conf
    PWord=`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 64 | head -n 1`
    echo rpcpassword=$PWord >> ~/.quarkcoin/quarkcoin.conf
fi

##Remove bootstrap.dat.old if it exists
if [ -f ~/.quarkcoin/bootstrap.dat.old ]; then
    rm ~/.quarkcoin/bootstrap.dat.old
fi

##Start quarkcoind daemon
echo Running quarkd
~/quarkcoin-bin/bin/quarkd -maxconnections=80 -printtoconsole -shrinkdebugfile
