#!/bin/bash

set -e

JAVA_OPTS=${JAVA_OPTS:"-Xms:128m -Xmx:128m"}

exec java $JAVA_OPTS -jar /opt/schemaspy/schemaspy.jar "$@"
