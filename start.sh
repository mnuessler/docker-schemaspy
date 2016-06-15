#!/bin/bash

set -e

JAVA_OPTS=${JAVA_OPTS:-"-client"}

exec java $JAVA_OPTS -jar /opt/schemaspy/schemaspy.jar "$@"
