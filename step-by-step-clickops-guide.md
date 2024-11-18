# Deploying a Static Website on AWS S3 with Route 53 - Console Guide

## Prerequisites
- AWS Account with appropriate permissions
- Domain registered in Route 53
- Your static website files ready for deployment
- AWS Management Console access

## 1. Create an S3 Bucket

1. Open the [S3 Console](https://s3.console.aws.amazon.com)
2. Click "Create bucket"
3. For "Bucket name", enter your domain name (e.g., `sohiverse.cloud`)
4. Select "US East (N. Virginia) us-east-1" as the Region
5. Uncheck "Block all public access"
6. Acknowledge that the bucket will be public
7. Keep other settings as default
8. Click "Create bucket"

## 2. Enable Static Website Hosting

1. Click on your newly created bucket
2. Go to the "Properties" tab
3. Scroll down to "Static website hosting"
4. Click "Edit"
5. Select "Enable"
6. For "Hosting type", choose "Host a static website"
7. Enter "index.html" for Index document
8. Enter "error.html" for Error document
9. Click "Save changes"
10. Note down the bucket website endpoint (will look like `http://your-domain.com.s3-website-us-east-1.amazonaws.com`)

## 3. Configure Bucket Policy

1. Go to the "Permissions" tab
2. Under "Bucket policy", click "Edit"
3. Copy and paste this policy (replace `sohiverse.cloud` with your domain):

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

4. Click "Save changes"

## 4. Upload Website Files

1. Go to https://www.free-css.com/free-css-templates
2. https://www.free-css.com/free-css-templates/page296/oxer
3. Click "Download"
4. Unzip the file
5. Upload the unzipped files to the bucket

1. Go to your bucket
2. Go to the "Objects" tab
3. Click "Upload"
4. Click "Add files" or drag and drop your website files
5. Keep default settings
6. Click "Upload"
7. Ensure your index.html is in the root of the bucket

## 5. Configure Route 53

1. Open the [Route 53 Console](https://console.aws.amazon.com/route53)
2. Go to "Hosted zones"
3. Click on your domain name
4. Click "Create record"
5. Leave "Record name" empty for root domain
6. Choose "A - Routes traffic to an IPv4 address and some AWS resources"
7. Toggle "Alias" on
8. Under "Route traffic to":
   - Choose "Alias to S3 website endpoint"
   - Select "us-east-1" region
   - Choose your bucket endpoint
9. Keep "Routing policy" as "Simple routing"
10. Click "Create records"

## 6. Verify Setup

1. Wait a few minutes for DNS propagation
2. Test your website by:
   - Opening your domain in a browser
   - Opening the S3 website endpoint directly
   - Opening `http://your-domain.com`

## Troubleshooting Common Issues

### 403 Forbidden Error
- Check bucket policy is properly configured
- Verify "Block all public access" is off
- Ensure files have proper permissions

### 404 Not Found Error
- Verify index.html exists in bucket root
- Check file names match exactly
- Ensure static website hosting is enabled

### DNS Not Resolving
- Confirm A record is properly configured
- Check if domain is properly registered
- Wait for DNS propagation (can take up to 48 hours)

### Website Not Loading
- Verify website endpoint is enabled
- Check if files are properly uploaded
- Ensure index.html is in root directory

## Maintenance Tasks

### Update Website Content
1. Go to bucket "Objects" tab
2. Upload new files or delete existing ones
3. Ensure proper file permissions

### Check Configuration
1. Review bucket properties for website hosting settings
2. Verify bucket policy is still correct
3. Test website accessibility regularly

Remember to replace `sohiverse.cloud` with your actual domain name throughout these steps.