docker build -t ktryber/multi-client:latest -t ktryber/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ktryber/multi-server:latest -t ktryber/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ktryber/multi-worker:latest -t ktryber/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ktryber/multi-client:latest
docker push ktryber/multi-server:latest
docker push ktryber/multi-worker:latest

docker push ktryber/multi-client:$SHA
docker push ktryber/multi-server:$SHA
docker push ktryber/multi-worker:$SHA 

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=ktryber/multi-server:$SHA
kubectl set image deployments/client-deployment client=ktryber/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ktryber/multi-worker:$SHA
