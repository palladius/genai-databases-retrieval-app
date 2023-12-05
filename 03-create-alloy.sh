#!/bin/bash

set -euo pipefail

direnv allow

gcloud alloydb clusters create $CLUSTER \
    --password=$DB_PASS\
    --network=default \
    --region=$REGION \
    --project=$PROJECT_ID

gcloud alloydb instances create $INSTANCE \
    --instance-type=PRIMARY \
    --cpu-count=8 \
    --region=$REGION \
    --cluster=$CLUSTER \
    --project=$PROJECT_ID \
    --ssl-mode=ALLOW_UNENCRYPTED_AND_ENCRYPTED

export ALLOYDB_IP=$(gcloud alloydb instances describe $INSTANCE \
    --cluster=$CLUSTER \
    --region=$REGION \
    --format 'value(ipAddress)')


echo "Riccardo: ALLOYDB_IP: $ALLOYDB_IP"
