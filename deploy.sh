docker build -t venkatamanne/multi-client:latest -t venkatamanne/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t venkatamanne/multi-server:latest -t venkatamanne/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t venkatamanne/multi-worker:latest -t venkatamanne/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push venkatamanne/multi-client:latest
docker push venkatamanne/multi-server:latest
docker push venkatamanne/multi-worker:latest

docker push venkatamanne/multi-client:$SHA
docker push venkatamanne/multi-server:$SHA
docker push venkatamanne/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=venkatamanne/multi-server:$SHA
kubectl set image deployments/client-deployment client=venkatamanne/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=venkatamanne/multi-worker:$SHA