docker build -t dado83/multi-client:latest -t dado83/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dado83/multi-server:latest -t dado83/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dado83/multi-worker:latest -t dado83/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push dado83/multi-client:latest
docker push dado83/multi-server:latest
docker push dado83/multi-worker:latest

docker push dado83/multi-client:$SHA
docker push dado83/multi-server:$SHA
docker push dado83/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=dado83/multi-server:$SHA
kubectl set image deployments/client-deployment client=dado83/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=dado83/multi-worker:$SHA