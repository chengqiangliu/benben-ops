### Install Prometheus and Grafana:
1. go to this current project folder.
2. run the following command to copy required yaml files to k8s master node
   
   ```
   scp -r src/scripts/prometheus-grafana root@hadoop101:/root
   ```
3. login to the k8s master node, and go to the "/root/prometheus-grafana" folder

4. run the following command to create node exporter
   ```
   kubectl create -f node-exporter.yaml
   ```
5. run the following command to create prometheus
   ```
   cd prometheus
   kubectl create -f rbac-setup.yaml
   kubectl create -f configmap.yaml
   kubectl create -f prometheus.deploy.yml
   kubectl create -f prometheus.svc.yml
   ```
6. run the following command to create prometheus
   ```
   cd grafana
   kubectl create -f grafana-deploy.yaml
   kubectl create -f grafana-svc.yaml
   kubectl create -f grafana-ing.yaml
   ```
7. run the following commnad to get the port of grafana
   ```
   kubectl get svc -n kube-system | grep grafana
   ```
8. open the http://{Worker Node IP}/{port of grafana}
   