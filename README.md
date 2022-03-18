# spark POC
### spark 3.2 pandas API feature
- pandas_on_spark.ipynb 파일 참조


# Docker File
### 1) single pyspark with jupyter notebook through dockerizing
- make Dockerfile
    - refers to below documents
    - https://github.com/jupyter/docker-stacks
    - https://it-sunny-333.tistory.com/88
- docker build -f single-node-spark/Dockerfile -t single-spark .
- docker run --rm -itd -p 9999:8888 -p 4040:4040 -v $(pwd)/single-node-spark/docker_volume:/usr/local/scripts --name spark single-spark
- docker inspect spark -> check configs (network, port, volume mounts...)

### 2) multiple pyspark with jupyter lab through docker
- make Dockerfile
    - mainly refers to below blog
    - https://todaycodeplus.tistory.com/31
- run shell script in spark-cluster folder
    - to make docker images of each components of spark-cluster
- docker-compose up -d
    - local volume 을 만들고 개별 component 들에게 공유하여 저장공간 마운트함
    - 계정에 따라 개별 volume 생성하고 만드는 방식으로 확장해볼 수 있을듯
- jupyter lab 에서 spark session 을 만들때에 만들어둔 spark cluster 를 바라보게끔 설정해야 함
    - SparkSession.builder.appName("anything").master("spark://spark-master:7077").config("spark.executor.memory", "512m").getOrCreate()
- sparkmaster:4040 왜 안 열리는지 확인 필요

### 3) through k8s
