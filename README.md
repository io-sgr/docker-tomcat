## Simple and production ready Tomcat docker images on top of CentOS

This repository contains **Dockerfile** of [Tomcat](http://tomcat.apache.org/) for [Docker](https://www.docker.com/)'s [automated build](https://hub.docker.com/r/sgrio/tomcat/) published to the public [Docker Hub](https://hub.docker.com/).

The following extra components and configurations has been applied to the Tomcat server in these images to make it `production ready`:
  * Unecessary files(.exe, .bat, etc.) and default applications(like host manager) has been removed to reduce image size
  * `APR` support, version `1.7.0`
  * `TC Native` support, version `1.2.23`

### Docker Tags

`sgrio/tomcat` provides several tagged images:

* Default (Your best choice)
  * `latest`: pointed to `8.5.64-jdk8-centos7`

* Tomcat 9
  Comming soon.

* Tomcat 8.5
  * Java 8
    * `8.5.64-jdk8-centos7`: Tomcat version `8.5.64` with `OpenJDK 8`

* Tomcat 7
  * Java 8
    * `7.0.96-jdk8-centos7`: Tomcat version `7.0.96` with `OpenJDK 8`

### Installation

1. Install [Docker](https://www.docker.com/).

2. Download [automated build](https://hub.docker.com/r/sgrio/tomcat/) from public [Docker Hub](https://hub.docker.com/): `docker pull sgrio/tomcat`

### Usage

    docker run -d -p 8080:8080 -v /path/to/webapp:/opt/apache-tomcat sgrio/tomcat

### Advanced

    You can always mount your own volumns to override the default configurations. I assume you know how to do that, right?
