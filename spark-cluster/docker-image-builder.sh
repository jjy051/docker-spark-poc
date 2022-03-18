#!/bin/bash

docker build \
  -f cluster-base-Dockerfile \
  -t cluster-base .

docker build \
  --build-arg spark_version="3.2.1" \
  --build-arg hadoop_version="3.2" \
  -f spark-base-Dockerfile \
  -t spark-base .

docker build \
  -f spark-master-Dockerfile \
  -t spark-master .

docker build \
  -f spark-worker-Dockerfile \
  -t spark-worker .

docker build \
  --build-arg spark_version="3.2.1" \
  --build-arg jupyterlab_version="2.1.5" \
  -f jupyter-lab-Dockerfile \
  -t jupyter-lab .