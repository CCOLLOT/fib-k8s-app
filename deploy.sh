docker build -t ccollot/client:latest -t ccollot/client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t ccollot/server:latest -t ccollot/server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t ccollot/worker:latest -t ccollot/worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push ccollot/client:latest
docker push ccollot/client:$GIT_SHA
docker push ccollot/server:latest
docker push ccollot/server:$GIT_SHA
docker push ccollot/worker:latest
docker push ccollot/worker:$GIT_SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment api=ccollot/server:$GIT_SHA
kubectl set image deployments/client-deployment client=ccollot/client:$GIT_SHA
kubectl set image deployments/worker-deployment worker=ccollot/worker:$GIT_SHA

