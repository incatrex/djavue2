#!/bin/bash
export COMPOSE_PROJECT_NAME=myproject_${CI_COMMIT_SHA}
docker-compose -f docker/compose/test.yml run myproject unittests.sh
exitcode=$?
docker-compose -f docker/compose/test.yml down
exit $exitcode
