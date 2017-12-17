# Quarkcoin node running in a Docker container

![QuarkCoin](https://d.thumbs.redditmedia.com/foNS2wiyEq2l-7VE.png)

[Adapted from DOGE](https://github.com/GXGOW/Docker-Dogecoin-fullnode)

Run a Quarkcoin fullnode in an isolated Docker container. Still a work in progress. Will update to include a full blockchain update process.

If you are new to Docker then you might [find the following helpful](http://itproguru.com/expert/2016/10/docker-create-container-change-container-save-as-new-image-and-connect-to-container/)

This assumes you already have a machine (Ubuntu in this case) with Docker installed already. If not then [check out this guide](https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/#install-docker-ce)

## How to use

### Build from source

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

The following snapshot of blocks was taken Dec 17th 2017 and will help your quarknode get up to sync much faster than waitiing for a full sync to occur since you won't have to download all of the blocks from scratch. Trust me, this will save you bandwidth and time.

```bash
# cd your home directory 
cd ~

# Stop the running quarknode (which is currently trying to sync)
sudo docker stop quarknode

# Use curl to download from Google drive (step 1):
curl -c /tmp/cookies "https://drive.google.com/uc?export=download&id=1u7yvzEipAGjVW0nMH5pmBFWQ-SoNT2Qx" > /tmp/quark-block-download.html

# Step 2 - actually perform the download (about 3 GB)
curl -L -b /tmp/cookies "https://drive.google.com$(cat /tmp/quark-block-download.html | grep -Po 'uc-download-link" [^>]* href="\K[^"]*' | sed 's/\&amp;/\&/g')" > ~/qrk-blocks-dec-17-2017.tgz

# Extract the contents
tar xvfz qrk-blocks-dec-17-2017.tgz 

cd blocks

# copy over the new downloaded blocks:
sudo docker cp . quarknode:/root/.quarkcoin/blocks/

# Start up your quarknode docker container
sudo docker start quarknode

#done
```

### Wallet management

More information coming shortly.



