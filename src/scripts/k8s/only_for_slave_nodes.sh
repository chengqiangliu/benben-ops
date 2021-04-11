#!/bin/bash

# 加入 Kubernetes Node
kubeadm join 192.168.10.111:6443 --token k0bcgz.jcwxms292n6qgu1z \
 --discovery-token-ca-cert-hash sha256:372e26ea350655c9f69ce72804cbbc25db6d96f0c854cc7631e14c6aac88202f
