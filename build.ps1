# Quick rebuild script

docker stop quarknode
docker rm quarknode
docker rmi quarkimage
docker build -t='quarkimage' .
docker run -d -p 8373:8373 --name quarknode quarkimage
