FROM ubuntu

## to avoid geo timezone option issue
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get -y install wget python3-pip openjdk-8-jdk
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-arm64

ARG spark_version="3.2.1"
ARG hadoop_version="3.2"

ENV APACHE_SPARK_VERSION="${spark_version}" \
    HADOOP_VERSION="${hadoop_version}"

### spark installation
WORKDIR /tmp
RUN wget -q "https://archive.apache.org/dist/spark/spark-${APACHE_SPARK_VERSION}/spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz" && \
    tar xzf "spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz" && \
    rm "spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz"

WORKDIR /usr/local

# Configure Spark
ENV SPARK_HOME=/usr/local/spark
ENV SPARK_OPTS="--driver-java-options=-Xms1024M --driver-java-options=-Xmx4096M --driver-java-options=-Dlog4j.logLevel=info" \
    PATH="${PATH}:${SPARK_HOME}/bin"

RUN ln -s /tmp/spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} spark


### jupyter notebook installation
RUN pip3 install jupyter

### pyspark connection to jupyter
ENV PYSPARK_PYTHON=python3
ENV PYSPARK_DRIVER_PYTHON=jupyter
ENV PYSPARK_DRIVER_PYTHON_OPTS='notebook --ip=0.0.0.0 --port=8888 --allow-root --NotebookApp.token='


# install python dependencies
RUN pip3 install pandas numpy pyarrow
RUN pip3 install matplotlib plotly


### copy data and create shared volume folder named scripts
COPY data /usr/local/data
RUN mkdir scripts

ENTRYPOINT [ "pyspark" ]