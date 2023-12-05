#!/bin/bash

set -euo pipefail

direnv allow




yellow "1. Create GCE vm for alloy proxy.."
gcloud compute instances create $VM_INSTANCE \
    --project=$PROJECT_ID \
    --zone=$ZONE \
    --machine-type=e2-medium \
    --network-interface=network-tier=PREMIUM,stack-type=IPV4_ONLY,subnet=default \
    --maintenance-policy=MIGRATE \
    --provisioning-model=STANDARD \
    --service-account=$PROJECT_NUM-compute@developer.gserviceaccount.com \
    --scopes=https://www.googleapis.com/auth/cloud-platform \
    --create-disk=auto-delete=yes,boot=yes,device-name=$VM_INSTANCE,image-family=ubuntu-2004-lts,image-project=ubuntu-os-cloud,mode=rw,size=10,type=projects/$PROJECT_ID/zones/$ZONE/diskTypes/pd-balanced \
    --no-shielded-secure-boot \
    --shielded-vtpm \
    --shielded-integrity-monitoring \
    --labels=goog-ec-src=vm_add-gcloud \
    --reservation-affinity=any


yellow "2. set up tunnel.."
gcloud compute ssh --project=$PROJECT_ID --zone=$ZONE $VM_INSTANCE \
                   -- -NL 5432:$ALLOYDB_IP:5432

psql -h 127.0.0.1 -U postgres
