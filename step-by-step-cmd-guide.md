
# Deploying a Static Website on AWS S3 with Route 53 (us-east-1)

## Prerequisites
- AWS Account with appropriate permissions
- AWS CLI installed and configured with us-east-1 as default region
- Domain registered in Route 53
- Your static website files ready for deployment

## 1. Create an S3 Bucket

aws s3 mb s3://your-domain.com --region us-east-1
aws s3 mb s3://sohiverse.cloud --region us-east-1

**Why**: Creates a bucket in us-east-1 that matches your domain name exactly.

## 2. Configure Bucket for Static Website Hosting

aws s3 website s3://your-domain.com --index-document index.html --error-document error.html
aws s3 website s3://sohiverse.cloud --index-document index.html --error-document error.html

**Why**: Enables static website hosting. Your website endpoint will be:
`http://your-domain.com.s3-website-us-east-1.amazonaws.com`

## 3. Configure Bucket Policy
Create a bucket policy file named `bucket-policy.json`:

{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::your-domain.com/*"
        }
    ]
}


{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::sohiverse.cloud/*"
        }
    ]
}


# command to fix json formatting while pasting in vim file

To fix JSON formatting while pasting in a Vim file, you can utilize a command that processes the JSON through an external tool like Python or `jq`. Here are several methods to achieve this:

## Using Python's `json.tool`

1. **Format the Entire File**: To format the entire JSON file, use the following command in Vim:
   
   :%!python -m json.tool
  
   This command pipes the entire content of the file through Python's JSON tool, which pretty-prints the JSON.

2. **Format Specific Lines**: If you want to format a specific range of lines, you can specify the line numbers:
   
   :3,5!python -m json.tool
  
   Replace `3,5` with your desired line range.

3. **Format Current Line**: To format just the current line you're on:
   
   :.!python -m json.tool
  

4. **Format Selected Text**: In Visual Mode, highlight the text you want to format and then run:
   
   :'<,'>!python -m json.tool
  

## Creating a Custom Command

# To simplify the process, you can add a custom command to your `.vimrc` file:


command! -range FormatJSON <line1>,<line2>!python -m json.tool


# After adding this, you can format JSON by simply typing `:FormatJSON` in command mode.

## Using `jq` for Formatting

Alternatively, if you prefer using `jq`, which is a powerful command-line JSON processor, you can format JSON with:


:%!jq .


# This will also format the entire file and is particularly useful if you have `jq` installed.

## Summary of Commands

| Command Type                | Command                          |
|-----------------------------|----------------------------------|
| Format Entire File          | `:%!python -m json.tool`        |
| Format Specific Lines       | `:3,5!python -m json.tool`      |
| Format Current Line         | `:.!python -m json.tool`        |
| Format Selected Text        | `:'<,'>!python -m json.tool`    |
| Custom Command              | `:FormatJSON` (after setup)     |
| Using jq                    | `:%!jq .`                        |

# These commands will help ensure that your JSON is well-formatted and easy to read while working in Vim.


# Review Current Settings: Check the current Block Public Access settings for your S3 bucket using the AWS CLI:
aws s3api get-public-access-block --bucket sohiverse.cloud

[cloudshell-user@ip-10-132-40-122 ~]$ aws s3api get-public-access-block --bucket sohiverse.cloud
{
    "PublicAccessBlockConfiguration": {
        "BlockPublicAcls": true,
        "IgnorePublicAcls": true,
        "BlockPublicPolicy": true,
        "RestrictPublicBuckets": true
    }
}

# Modify Block Public Access Settings
# If BlockPublicPolicy is enabled, you will need to disable it in order to apply a public policy
aws s3api put-public-access-block --bucket sohiverse.cloud --public-access-block-configuration '{
    "BlockPublicAcls": false,
    "IgnorePublicAcls": false,
    "BlockPublicPolicy": false,
    "RestrictPublicBuckets": false
}'


# Apply Your Bucket Policy
aws s3api put-bucket-policy --bucket sohiverse.cloud --policy file://bucket-policy.json


# Apply the policy:

aws s3api put-bucket-policy --bucket your-domain.com --policy file://bucket-policy.json
aws s3api put-bucket-policy --bucket sohiverse.cloud --policy file://bucket-policy.json

**Why**: Makes your bucket contents publicly readable, which is required for website hosting.

## 4. Upload Website Files

# To download the file from the provided URL using a command line interface, you can use the `curl` or `wget` command. Here are examples of both:

# Using `curl`

curl -O https://www.free-css.com/assets/files/free-css-templates/download/page296/oxer.zip


# Using `wget`

wget https://www.free-css.com/assets/files/free-css-templates/download/page296/oxer.zip


# Both commands will download the `oxer.zip` file to your current directory. Make sure you have either `curl` or `wget` installed on your system to use these commands.



aws s3 sync ./your-website-directory s3://your-domain.com --delete
aws s3 sync ./oxer-html s3://sohiverse.cloud --delete


**Why**: Uploads your website files to the S3 bucket.

## 5. Configure Route 53

### Get your Hosted Zone ID (if you don't already have it):

aws route53 list-hosted-zones --query 'HostedZones[?Name==`your-domain.com.`].Id' --output text
aws route53 list-hosted-zones --query 'HostedZones[?Name==`sohiverse.cloud.`].Id' --output text

# Create A Record alias pointing to S3 website endpoint:

aws route53 change-resource-record-sets \
    --hosted-zone-id YOUR_HOSTED_ZONE_ID \
    --change-batch '{
        "Changes": [{
            "Action": "CREATE",
            "ResourceRecordSet": {
                "Name": "your-domain.com",
                "Type": "A",
                "AliasTarget": {
                    "HostedZoneId": "Z3AQBSTGFYJSTF",
                    "DNSName": "s3-website-us-east-1.amazonaws.com",
                    "EvaluateTargetHealth": false
                }
            }
        }]
    }'

aws route53 change-resource-record-sets \
    --hosted-zone-id Z00334501MYUPA3SN5XXZ \
    --change-batch '{
        "Changes": [{
            "Action": "CREATE",
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



**Why**: Creates DNS record pointing your domain to the S3 website. Note that `Z3AQBSTGFYJSTF` is the fixed hosted zone ID for S3 website endpoints in us-east-1.

## 6. Verify Setup

### Check DNS Propagation:

dig your-domain.com
dig sohiverse.cloud

**Why**: Confirms DNS records are propagating.

### Test Website Accessibility:

# Test S3 website endpoint directly
curl -I http://your-domain.com.s3-website-us-east-1.amazonaws.com
curl -I http://sohiverse.cloud.s3-website-us-east-1.amazonaws.com

# Test your custom domain
curl -I http://your-domain.com
curl -I http://sohiverse.cloud

**Why**: Verifies both the S3 endpoint and your custom domain are working correctly.

## Common Maintenance Tasks

### Update Website Content:

aws s3 sync ./your-website-directory s3://your-domain.com --delete
aws s3 sync ./your-website-directory s3://sohiverse.cloud --delete

### Check Bucket Policy:

aws s3api get-bucket-policy --bucket your-domain.com
aws s3api get-bucket-policy --bucket sohiverse.cloud

### Verify Website Configuration:

aws s3api get-bucket-website --bucket your-domain.com
aws s3api get-bucket-website --bucket sohiverse.cloud

### List Bucket Contents:

aws s3 ls s3://your-domain.com
aws s3 ls s3://sohiverse.cloud


## Troubleshooting Common Issues

1. **403 Forbidden Error**
   - Check bucket policy is correctly applied
   
   aws s3api get-bucket-policy --bucket your-domain.com
   

2. **404 Not Found Error**
   - Verify index.html exists in bucket root
   
   aws s3 ls s3://your-domain.com/index.html
   

3. **DNS Not Resolving**
   - Verify A record in Route 53
   
   aws route53 list-resource-record-sets --hosted-zone-id YOUR_HOSTED_ZONE_ID
   

4. **Website Not Loading**
   - Check website endpoint is enabled
   
   aws s3api get-bucket-website --bucket your-domain.com
   

Remember to replace:
- `your-domain.com` with your actual domain
- `YOUR_HOSTED_ZONE_ID` with your Route 53 hosted zone ID
- `your-website-directory` with the path to your website files

