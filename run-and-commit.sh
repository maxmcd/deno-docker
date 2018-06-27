set -e
echo "Running $@"
docker run -it $VOLUMES $@
TO_COMMIT=$(docker ps -aq | head -n 1 | awk '{print $1}')
docker commit $TO_COMMIT $1 
