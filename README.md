# Quarkcoin node running in a Docker container

![QuarkCoin](https://d.thumbs.redditmedia.com/foNS2wiyEq2l-7VE.png)

[Adapted from DOGE](https://github.com/GXGOW/Docker-Dogecoin-fullnode)

Run a Quarkcoin fullnode in an isolated Docker container. Contains a full sync with the blockchain up to Dec 18th 2017. 

If you are new to Docker then you might [find the following helpful](http://itproguru.com/expert/2016/10/docker-create-container-change-container-save-as-new-image-and-connect-to-container/)

This [Docker Cheat Sheet](https://github.com/wsargent/docker-cheat-sheet) is also a good overview of what Docker can do.

This assumes you already have a machine (Ubuntu in this case) with Docker installed. If not then [check out this guide](https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/#install-docker-ce). Keep in mind that Docker can run on any platform, I'm picking Linux here just to show the generic commands.

## How to use

### Option 1: Download from Docker

Just [download the image](https://store.docker.com/community/images/imcm/quarknode) and run it! Running the image will create a new container with a fresh wallet that is completely yours. The Docker image you download does not contain a wallet file, so whenever you execute the 'docker run' command you'll basically start from scratch again with a fresh wallet. However, the blockchain will still be reset back to the snapshot of Dec 18th 2017.

```bash
sudo docker run -d -p 8373:8373 --name quarknode imcm/quarknode:dec182017
```

### Option 2: Build from source

```bash
# Clone the git repository
git clone https://github.com/imcmurray/quarkcoin-docker-node.git

# Perform your customisations (optional)

# Run the build script (it'll also run as a .sh script. Just copy the contents or change the file extension.)

chmod +x build.ps1

./build.ps1

Then you can access the running docker container with something like:
docker attach quarknode
```

### Quick block update

The following snapshot of blocks was taken Dec 18th 2017 and will help your quarknode get up to sync much faster than waitiing for a full sync to occur since you won't have to download all of the blocks from scratch. Trust me, this will save you bandwidth and time.

```bash
# cd your home directory 
cd ~

# Stop the running quarknode (which is currently trying to sync)
sudo docker stop quarknode

# Use curl to download from Google drive (step 1):
curl -c /tmp/cookies "https://drive.google.com/uc?export=download&id=1OAx2VqtnabZhLH-wO3gHc5F91sr6Qbfo" > /tmp/quark-block-download.html

# Step 2 - actually perform the download (about 3 GB)
curl -L -b /tmp/cookies "https://drive.google.com$(cat /tmp/quark-block-download.html | grep -Po 'uc-download-link" [^>]* href="\K[^"]*' | sed 's/\&amp;/\&/g')" > ~/qrk-sync-dec-18-2017.tgz

# Extract the contents
tar xvfz qrk-sync-dec-18-2017.tgz 

cd blocks

# copy over the new downloaded blocks:
sudo docker cp . quarknode:/root/.quarkcoin/blocks/

# Start up your quarknode docker container
sudo docker start quarknode

#done
```

## Accessing the container

**Important** Once a container has been created with either option above, remember to not follow either of the options again, unless you want to clear out your wallet.

Also, when you initially start the container, keep in mind that it can also take upto 45 minutes before it's on the network and actively participating. I think this is due to the limited amount of RAM on the virtual machines.

Also, once you have a container running, the nice way to stop the container is to stop the Quark daemon first. Once Quark has been stopped them the container will automatically end since that was the only process that we told the container to execute.

How to see what your quarknode is doing:

```bash
sudo docker attach --sig-proxy=false quarknode
```

This is view only and you can quit out of that command (CTRL+c) without causing any damage to the container. If you don't see anything pop up for a while, keep in mind that it can take upto 45 minutes for the daemon to be happy and join the network. Once joined you'll see network information (assuming you're attached to the container).

if you want to run additional commands in the container, say to look at your wallet, create new addresses, and or send Quark, then you'll need to do the following:

```bash
sudo docker exec -it quarknode bash
```

and you'll be presented with a command line directly into the container. Once connected you can use something like the following to view the status of your quarknode:

```bash
quark-cli getinfo
```


## Stopping the container the right way:

```bash
sudo docker exec -it quarknode bash

# To stop the Quark daemon
quark-cli stop

exit
```

Then you can exit out of the session and the container will automatically stop when the daemon has exited successfully. Keep in mind that my 512MB virtual server takes about 25 minutes for Quark to exit.

Finally, if you've found this information helpful, please consider donating to help me know that there was somebody out there who found some benefit to this information.

QRK Address: QhVj6WwnSPtUzyEQF3xHgCMWmePDe9BQvf
