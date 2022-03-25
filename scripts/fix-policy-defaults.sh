#!/bin/bash
# Modify Org Policies that are too restrictive for the toolkit
# Note: Organization Policy Administrator IAM permissions are needed to run this script
# References:
# - https://cloud.google.com/sdk/gcloud/reference/beta/resource-manager
# - https://cloud.google.com/compute/docs/images/restricting-image-access#trusted_images
#
# USAGE: fix-policy-defaults.sh [PROJECT_ID]
# if no project is given, the current gcloud project is used
 
project=${1:-`gcloud config get-value project`}

declare -a policies=(
    "constraints/compute.trustedImageProjects"
    "constraints/compute.vmExternalIpAccess"
    "constraints/compute.restrictSharedVpcSubnetworks"
    "constraints/compute.restrictSharedVpcHostProjects"
    "constraints/compute.restrictVpcPeering"
    "constraints/compute.restrictVpnPeerIPs"
    "constraints/compute.vmCanIpForward"
    "constraints/compute.requireShieldedVm"
    "constraints/compute.requireOsLogin"
    "constraints/iam.disableServiceAccountKeyCreation"
    "constraints/iam.disableServiceAccountCreation"
)

for policy in "${policies[@]}"
do
    gcloud org-policies reset $policy --project=$project
done