#!/bin/bash

set -euo pipefail

export RANGE_NAME=my-allocated-range-default
export DESCRIPTION="peering range for alloydb-service"

gcloud compute addresses create $RANGE_NAME \
    --global \
    --purpose=VPC_PEERING \
    --prefix-length=16 \
    --description="$DESCRIPTION" \
    --network=default

    gcloud services vpc-peerings connect \
    --service=servicenetworking.googleapis.com \
    --ranges="$RANGE_NAME" \
    --network=default