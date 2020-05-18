docker build -t karansuryadevra/multi-client:latest -t karansuryadevra/multi-client:$SHA ./client/Dockerfile ./client
docker build -t karansuryadevra/multi-server:latest -t karansuryadevra/multi-server:$SHA ./server/Dockerfile ./server
docker build -t karansuryadevra/multi-worker:latest -t karansuryadevra/multi-worker:$SHA ./worker/Dockerfile ./worker
docker push karansuryadevra/multi-client:latest
docker push karansuryadevra/multi-client:$SHA
docker push karansuryadevra/multi-server:latest
docker push karansuryadevra/multi-server:$SHA
docker push karansuryadevra/multi-worker:latest
docker push karansuryadevra/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=karansuryadevra/multi-server:$SHA
kubectl set image deployments/client-deployment client=karansuryadevra/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=karansuryadevra/multi-worker:$SHA