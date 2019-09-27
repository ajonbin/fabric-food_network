#!/bin/bash
set -x

docker-compose -f docker-compose-farmer.yaml -f docker-compose-government.yaml -f docker-compose-transport.yaml -f docker-compose-supermarket.yaml -f docker-compose-cli.yaml up

