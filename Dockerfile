FROM ubuntu:17.04

ADD init.sh /
ADD quarkcoin.tgz /root
ADD qrk-sync-dec-18-2017.tgz /root
EXPOSE 8373
ENTRYPOINT ["/bin/bash"]
CMD ["/init.sh"]
LABEL name="quarkcoin-node" version="0.1" description="Quarkcoin fullnode container based off Ubuntu"
