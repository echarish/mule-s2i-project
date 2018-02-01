
# echarish/mule-s2i-image
FROM openshift/base-centos7
FROM java:8

MAINTAINER HARISH KUMAR <echarish@gmail.com >

ENV MULE_VERSION 3.9.0
ENV GRADLE_VERSION=4.0.1

WORKDIR /opt
RUN wget https://s3.amazonaws.com/new-mule-artifacts/mule-ee-distribution-standalone-${MULE_VERSION}.tar.gz && \
    tar xvzf mule-ee-distribution-standalone-${MULE_VERSION}.tar.gz && \
    rm -rf mule-ee-distribution-standalone-${MULE_VERSION}.tar.gz && \
    mv /opt/mule-enterprise-standalone-${MULE_VERSION} /opt/mule

# Install Gradle
RUN wget https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip && \
    mkdir /opt/gradle && \
    unzip -d /opt/gradle gradle-${GRADLE_VERSION}-bin.zip && \
    rm gradle-${GRADLE_VERSION}-bin.zip && \
    ln -s /opt/gradle/gradle-${GRADLE_VERSION}/bin/gradle /usr/local/bin/gradle


LABEL io.k8s.description="Platform for building Mule ${MULE_VERSION} CE applications" \
    io.k8s.display-name="Mule ${MULE_VERSION} builder 1.0" \
    io.openshift.expose-services="8081:http" \
    io.openshift.tags="builder,gradle,mule-${MULE_VERSION}"

LABEL io.openshift.s2i.scripts-url=image:///usr/libexec/s2i
COPY ./s2i/bin/ /usr/libexec/s2i

RUN chmod -R 777 /usr/libexec/s2i
RUN chown -R 1001:1001 /opt && chmod -R 777 /opt

# default user
USER 1001


# Set the default port for applications HTTP and event bus
# Mule App port
EXPOSE 8081
# Mule MMC port
EXPOSE 7777
