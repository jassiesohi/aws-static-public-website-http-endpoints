#!/bin/bash

# Set your domain and hosted zone ID
DOMAIN="sohiverse.cloud"
HOSTED_ZONE_ID="Z00334501MYUPA3SN5XXZ"

echo "Starting cleanup process..."

# 1. Delete Route 53 A Record
echo "Deleting Route 53 A Record..."
aws route53 change-resource-record-sets \
    --hosted-zone-id $HOSTED_ZONE_ID \
    --change-batch '{
        "Changes": [{
            "Action": "DELETE",
            "ResourceRecordSet": {
                "Name": "sohiverse.cloud",
                "Type": "A",
                "AliasTarget": {
                    "HostedZoneId": "Z3AQBSTGFYJSTF",
                    "DNSName": "s3-website-us-east-1.amazonaws.com",
                    "EvaluateTargetHealth": false
                }
            }
        }]
    }'

# 2. Empty S3 bucket (required before deletion)
echo "Emptying S3 bucket..."
aws s3 rm s3://$DOMAIN --recursive

# 3. Delete bucket policy
echo "Deleting bucket policy..."
aws s3api delete-bucket-policy --bucket $DOMAIN

# 4. Delete bucket website configuration
echo "Deleting bucket website configuration..."
aws s3api delete-bucket-website --bucket $DOMAIN

# 5. Delete S3 bucket
echo "Deleting S3 bucket..."
aws s3 rb s3://$DOMAIN

echo "Cleanup completed!"

# Verify cleanup
echo "Verifying cleanup..."
echo "Checking if bucket still exists..."
aws s3 ls s3://$DOMAIN 2>&1 || echo "Bucket deleted successfully"

echo "Checking Route 53 A record..."
aws route53 list-resource-record-sets --hosted-zone-id $HOSTED_ZONE_ID \
    --query "ResourceRecordSets[?Name=='$DOMAIN.']"