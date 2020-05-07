docker build -t sethsacher/multi-client:latest -t sethsacher/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sethsacher/multi-server:latest -t sethsacher/multi-server:$SHA -f ./server/Dockerfile ./server 
docker build -t sethsacher/multi-worker:latest -t sethsacher/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sethsacher/multi-client:latest
docker push sethsacher/multi-client:$SHA
docker push sethsacher/multi-server:latest
docker push sethsacher/multi-server:$SHA
docker push sethsacher/multi-worker:latest
docker push sethsacher/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=sethsacher/multi-server:$SHA
kubectl set image deployments/client-deployment client=sethsacher/multi-client:$SHA 
kubectl set image deployments/worker-deployment worker=sethsacher/multi-worker:$SHA