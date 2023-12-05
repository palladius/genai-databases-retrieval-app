#!/bin/bash

set -euo pipefail

direnv allow 

#export PROJECT_ID=<YOUR_PROJECT_ID>
gcloud config configurations create   genai-allowydb-rag --activate ||
    echo Maybe it already exists.. lets give it a chance.
gcloud config configurations activate genai-allowydb-rag

echodo gcloud config set project "$PROJECT_ID"
echodo gcloud config set account ricc@google.com

echodo gcloud services enable alloydb.googleapis.com \
                       compute.googleapis.com \
                       cloudresourcemanager.googleapis.com \
                       servicenetworking.googleapis.com \
                       vpcaccess.googleapis.com \
                       aiplatform.googleapis.com


verde Fatto ric.