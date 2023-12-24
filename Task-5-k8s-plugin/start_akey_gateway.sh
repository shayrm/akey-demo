
echo "starting Akeyless Gateway..."

docker run -d \
        -p 8000:8000 \
        -p 8200:8200 \
        -p 18888:18888 \
        -p 8080:8080 \
        -p 8081:8081 \
        -p 5696:5696 \
        -e ADMIN_ACCESS_ID="shay_m@yahoo.com" \
        --name akeyless-gw-2 akeyless/base


docker ps
sleep 4
docker logs -f akeyless-gw-2 

