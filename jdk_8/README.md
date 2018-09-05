## Simple and production ready Tomcat docker images on top of Ubuntu

This repository contains **Dockerfile** of [Ubuntu](http://www.ubuntu.com/) for [Docker](https://www.docker.com/)'s [automated build](https://hub.docker.com/r/sgrio/tomee/) published to the public [Docker Hub](https://hub.docker.com/).

The following extra components and configurations has been applied to the Tomcat server in these images to make it `production ready`:
  * Unecessary files(.exe, .bat, etc.) and default applications(like host manager) has been removed to reduce image size
  * `APR` support, version `1.6.3`
  * `TC Native` support, version `1.2.17`

### Docker Tags

`sgrio/tomcat` provides several tagged images:

* Default (Your best choice)
  * `latest`: pointed to `latest_tomcat_7`

* Tomcat 9
  Comming soon.

* Tomcat 8
  Comming soon.

* Tomcat 7
  * Java 8
    * `v7_latest`: pointed to `v7_server_jre_8`
    * `v7_server_jre_8`: Tomcat version `7.0.88` with `Oracle Java SE Server Runtime Environment 8`
    * `v7_jdk_8`: Tomcat version `7.0.88` with `Oracle Java SE Development Kit 8`

### Installation

1. Install [Docker](https://www.docker.com/).

2. Download [automated build](https://hub.docker.com/r/sgrio/tomcat/) from public [Docker Hub](https://hub.docker.com/): `docker pull sgrio/tomcat`

### Usage

    docker run -d -p 8080:8080 -v /path/to/webapp:/opt/apache-tomcat sgrio/tomcat

### Advanced

    You can always mount your own volumns to override the default configurations. I assume you know how to do that, right?
