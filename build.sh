#!/bin/bash

JMETER_VERSION=${JMETER_VERSION:-"5.2.1"}
IMAGE_TIMEZONE=${IMAGE_TIMEZONE:-"Asia/Jakarta"}

# Example build line
docker build  --build-arg JMETER_VERSION=${JMETER_VERSION} --build-arg TZ=${IMAGE_TIMEZONE} -t "telkomdev/jmeter:${JMETER_VERSION}" .