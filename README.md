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

Need to also define management of wallet files.


