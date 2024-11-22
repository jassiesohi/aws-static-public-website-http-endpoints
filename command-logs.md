
[cloudshell-user@ip-10-138-178-108 ~]$ aws s3 mb s3://sohiverse.cloud --region us-east-1
make_bucket: sohiverse.cloud
[cloudshell-user@ip-10-138-178-108 ~]$ aws s3 website s3://sohiverse.cloud --index-document index.html
[cloudshell-user@ip-10-138-178-108 ~]$ ls
bkp  bucket-policy.json
[cloudshell-user@ip-10-138-178-108 ~]$ vi bucket-policy.json 
[cloudshell-user@ip-10-138-178-108 ~]$ aws s3api get-public-access-block --bucket sohiverse.cloud
{
    "PublicAccessBlockConfiguration": {
        "BlockPublicAcls": true,
        "IgnorePublicAcls": true,
        "BlockPublicPolicy": true,
        "RestrictPublicBuckets": true
    }
}
[cloudshell-user@ip-10-138-178-108 ~]$ aws s3api put-public-access-block --bucket sohiverse.cloud --public-access-block-configuration '{
>     "BlockPublicAcls": false,
>     "IgnorePublicAcls": false,
>     "BlockPublicPolicy": false,
>     "RestrictPublicBuckets": false
> }'
[cloudshell-user@ip-10-138-178-108 ~]$ aws s3api get-public-access-block --bucket sohiverse.cloud
{
    "PublicAccessBlockConfiguration": {
        "BlockPublicAcls": false,
        "IgnorePublicAcls": false,
        "BlockPublicPolicy": false,
        "RestrictPublicBuckets": false
    }
}
[cloudshell-user@ip-10-138-178-108 ~]$ aws s3api put-bucket-policy --bucket sohiverse.cloud --policy file://bucket-policy.json
[cloudshell-user@ip-10-138-178-108 ~]$ curl -O https://www.free-css.com/assets/files/free-css-templates/download/page296/oxer.zip
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 1663k  100 1663k    0     0  1344k      0  0:00:01  0:00:01 --:--:-- 1345k
[cloudshell-user@ip-10-138-178-108 ~]$ ls
bkp  bucket-policy.json  oxer.zip
[cloudshell-user@ip-10-138-178-108 ~]$ unzip oxer.zip 
Archive:  oxer.zip
   creating: oxer-html/
  inflating: oxer-html/about.html    
  inflating: oxer-html/blog.html     
  inflating: oxer-html/class.html    
   creating: oxer-html/css/
  inflating: oxer-html/css/bootstrap.css  
  inflating: oxer-html/css/responsive.css  
  inflating: oxer-html/css/style.css  
  inflating: oxer-html/css/style.css.map  
  inflating: oxer-html/css/style.scss  
   creating: oxer-html/images/
  inflating: oxer-html/images/about-bg.jpg  
  inflating: oxer-html/images/b1.jpg  
  inflating: oxer-html/images/b2.jpg  
  inflating: oxer-html/images/c1.jpg  
  inflating: oxer-html/images/c2.jpg  
  inflating: oxer-html/images/client1.png  
  inflating: oxer-html/images/client2.png  
  inflating: oxer-html/images/facebook.png  
  inflating: oxer-html/images/footer-img.jpg  
  inflating: oxer-html/images/hero-bg.jpg  
  inflating: oxer-html/images/instagram.png  
  inflating: oxer-html/images/left-angle.png  
  inflating: oxer-html/images/left-black-arrow.png  
  inflating: oxer-html/images/linkedin.png  
  inflating: oxer-html/images/location.png  
  inflating: oxer-html/images/logo.png  
  inflating: oxer-html/images/mail.png  
  inflating: oxer-html/images/menu.png  
  inflating: oxer-html/images/next-arrow.png  
  inflating: oxer-html/images/next-grey.png  
  inflating: oxer-html/images/next.png  
  inflating: oxer-html/images/play-icon.png  
  inflating: oxer-html/images/prev-arrow.png  
  inflating: oxer-html/images/prev-grey.png  
  inflating: oxer-html/images/prev.png  
  inflating: oxer-html/images/quote.png  
  inflating: oxer-html/images/right-angle.png  
  inflating: oxer-html/images/right-black-arrow.png  
  inflating: oxer-html/images/search-icon.png  
  inflating: oxer-html/images/telephone.png  
  inflating: oxer-html/images/twitter.png  
  inflating: oxer-html/images/youtube.png  
  inflating: oxer-html/index.html    
   creating: oxer-html/js/
  inflating: oxer-html/js/bootstrap.js  
  inflating: oxer-html/js/jquery-3.4.1.min.js  
[cloudshell-user@ip-10-138-178-108 ~]$ ls
bkp  bucket-policy.json  oxer-html  oxer.zip
[cloudshell-user@ip-10-138-178-108 ~]$ aws s3 sync ./oxer-html s3://sohiverse.cloud --delete
upload: oxer-html/class.html to s3://sohiverse.cloud/class.html                        
upload: oxer-html/about.html to s3://sohiverse.cloud/about.html                        
upload: oxer-html/blog.html to s3://sohiverse.cloud/blog.html                          
upload: oxer-html/css/responsive.css to s3://sohiverse.cloud/css/responsive.css      
upload: oxer-html/css/style.css.map to s3://sohiverse.cloud/css/style.css.map        
upload: oxer-html/images/c1.jpg to s3://sohiverse.cloud/images/c1.jpg                
upload: oxer-html/css/style.css to s3://sohiverse.cloud/css/style.css                 
upload: oxer-html/images/about-bg.jpg to s3://sohiverse.cloud/images/about-bg.jpg     
upload: oxer-html/css/bootstrap.css to s3://sohiverse.cloud/css/bootstrap.css
upload: oxer-html/css/style.scss to s3://sohiverse.cloud/css/style.scss
upload: oxer-html/images/instagram.png to s3://sohiverse.cloud/images/instagram.png
upload: oxer-html/images/c2.jpg to s3://sohiverse.cloud/images/c2.jpg
upload: oxer-html/images/hero-bg.jpg to s3://sohiverse.cloud/images/hero-bg.jpg
upload: oxer-html/images/b1.jpg to s3://sohiverse.cloud/images/b1.jpg
upload: oxer-html/images/b2.jpg to s3://sohiverse.cloud/images/b2.jpg
upload: oxer-html/images/linkedin.png to s3://sohiverse.cloud/images/linkedin.png
upload: oxer-html/images/location.png to s3://sohiverse.cloud/images/location.png
upload: oxer-html/images/logo.png to s3://sohiverse.cloud/images/logo.png
upload: oxer-html/images/next-arrow.png to s3://sohiverse.cloud/images/next-arrow.png
upload: oxer-html/images/left-angle.png to s3://sohiverse.cloud/images/left-angle.png
upload: oxer-html/images/left-black-arrow.png to s3://sohiverse.cloud/images/left-black-arrow.png
upload: oxer-html/images/menu.png to s3://sohiverse.cloud/images/menu.png
upload: oxer-html/images/client1.png to s3://sohiverse.cloud/images/client1.png
upload: oxer-html/images/next-grey.png to s3://sohiverse.cloud/images/next-grey.png
upload: oxer-html/images/facebook.png to s3://sohiverse.cloud/images/facebook.png
upload: oxer-html/images/mail.png to s3://sohiverse.cloud/images/mail.png
upload: oxer-html/images/prev-grey.png to s3://sohiverse.cloud/images/prev-grey.png
upload: oxer-html/images/right-black-arrow.png to s3://sohiverse.cloud/images/right-black-arrow.png
upload: oxer-html/images/prev-arrow.png to s3://sohiverse.cloud/images/prev-arrow.png
upload: oxer-html/images/quote.png to s3://sohiverse.cloud/images/quote.png
upload: oxer-html/images/prev.png to s3://sohiverse.cloud/images/prev.png
upload: oxer-html/images/play-icon.png to s3://sohiverse.cloud/images/play-icon.png
upload: oxer-html/images/client2.png to s3://sohiverse.cloud/images/client2.png
upload: oxer-html/images/right-angle.png to s3://sohiverse.cloud/images/right-angle.png
upload: oxer-html/images/next.png to s3://sohiverse.cloud/images/next.png
upload: oxer-html/images/search-icon.png to s3://sohiverse.cloud/images/search-icon.png
upload: oxer-html/images/footer-img.jpg to s3://sohiverse.cloud/images/footer-img.jpg
upload: oxer-html/images/telephone.png to s3://sohiverse.cloud/images/telephone.png
upload: oxer-html/images/youtube.png to s3://sohiverse.cloud/images/youtube.png
upload: oxer-html/js/jquery-3.4.1.min.js to s3://sohiverse.cloud/js/jquery-3.4.1.min.js
upload: oxer-html/index.html to s3://sohiverse.cloud/index.html 
upload: oxer-html/images/twitter.png to s3://sohiverse.cloud/images/twitter.png
upload: oxer-html/js/bootstrap.js to s3://sohiverse.cloud/js/bootstrap.js
[cloudshell-user@ip-10-138-178-108 ~]$ aws route53 list-hosted-zones --query 'HostedZones[?Name==`sohiverse.cloud.`].Id' --output text
/hostedzone/Z00334501MYUPA3SN5XXZ
[cloudshell-user@ip-10-138-178-108 ~]$ aws route53 change-resource-record-sets \
>     --hosted-zone-id Z00334501MYUPA3SN5XXZ \
>     --change-batch '{
>         "Changes": [{
>             "Action": "CREATE",
>             "ResourceRecordSet": {
>                 "Name": "sohiverse.cloud",
>                 "Type": "A",
>                 "AliasTarget": {
>                     "HostedZoneId": "Z3AQBSTGFYJSTF",
>                     "DNSName": "s3-website-us-east-1.amazonaws.com",
>                     "EvaluateTargetHealth": false
>                 }
>             }
>         }]
>     }'
{
    "ChangeInfo": {
        "Id": "/change/C05522006M6I59XVLXTG",
        "Status": "PENDING",
        "SubmittedAt": "2024-11-18T14:00:01.492000+00:00"
    }
}
[cloudshell-user@ip-10-138-178-108 ~]$ curl -I http://sohiverse.cloud.s3-website-us-east-1.amazonaws.com
HTTP/1.1 200 OK
x-amz-id-2: WdUHTorGOBuHmfDVIDzxTCtVIZEa5oE0vPt5oaex/frWGTC5kQnCc48WgaKiXdy+BKL8EvCpe7g=
x-amz-request-id: S8Q5D1GK14YTZ60H
Date: Mon, 18 Nov 2024 14:01:33 GMT
Last-Modified: Mon, 18 Nov 2024 13:58:34 GMT
ETag: "b8c4c1008690a76bd49e5d173607018d"
Content-Type: text/html
Content-Length: 23696
Server: AmazonS3

[cloudshell-user@ip-10-138-178-108 ~]$ curl -I http://sohiverse.cloud
HTTP/1.1 200 OK
x-amz-id-2: xQhjPVBw9XlkL0g/ZZUx/zimN4QWf2rjCFQvHve9dVEVHZXJnj4B3vBzqoHngMIWo9zas4pmtH4=
x-amz-request-id: KN1ZEXEWP1FCF29D
Date: Mon, 18 Nov 2024 14:01:52 GMT
Last-Modified: Mon, 18 Nov 2024 13:58:34 GMT
ETag: "b8c4c1008690a76bd49e5d173607018d"
Content-Type: text/html
Content-Length: 23696
Server: AmazonS3

[cloudshell-user@ip-10-138-178-108 ~]$ ls
bkp  bucket-policy.json  cleanup-s3cmd-env.sh  oxer-html  oxer.zip
[cloudshell-user@ip-10-138-178-108 ~]$ chmod +x cleanup-s3cmd-env.sh
[cloudshell-user@ip-10-138-178-108 ~]$ ./cleanup-s3cmd-env.sh
Starting cleanup process...
Deleting Route 53 A Record...
{
    "ChangeInfo": {
        "Id": "/change/C011668834D74Z7H264BA",
        "Status": "PENDING",
        "SubmittedAt": "2024-11-18T14:04:23.917000+00:00"
    }
}
Emptying S3 bucket...
delete: s3://sohiverse.cloud/class.html
delete: s3://sohiverse.cloud/blog.html
delete: s3://sohiverse.cloud/about.html
delete: s3://sohiverse.cloud/images/c2.jpg
delete: s3://sohiverse.cloud/css/bootstrap.css
delete: s3://sohiverse.cloud/images/client2.png
delete: s3://sohiverse.cloud/images/c1.jpg
delete: s3://sohiverse.cloud/images/hero-bg.jpg
delete: s3://sohiverse.cloud/images/footer-img.jpg
delete: s3://sohiverse.cloud/css/style.css
delete: s3://sohiverse.cloud/css/style.scss
delete: s3://sohiverse.cloud/css/responsive.css
delete: s3://sohiverse.cloud/images/b1.jpg
delete: s3://sohiverse.cloud/images/b2.jpg
delete: s3://sohiverse.cloud/images/left-angle.png
delete: s3://sohiverse.cloud/images/mail.png
delete: s3://sohiverse.cloud/images/instagram.png
delete: s3://sohiverse.cloud/images/linkedin.png
delete: s3://sohiverse.cloud/images/logo.png
delete: s3://sohiverse.cloud/images/left-black-arrow.png
delete: s3://sohiverse.cloud/images/location.png
delete: s3://sohiverse.cloud/images/menu.png
delete: s3://sohiverse.cloud/images/next-arrow.png
delete: s3://sohiverse.cloud/images/next-grey.png
delete: s3://sohiverse.cloud/images/play-icon.png
delete: s3://sohiverse.cloud/images/prev-grey.png
delete: s3://sohiverse.cloud/images/prev-arrow.png
delete: s3://sohiverse.cloud/images/quote.png
delete: s3://sohiverse.cloud/images/right-angle.png
delete: s3://sohiverse.cloud/images/right-black-arrow.png
delete: s3://sohiverse.cloud/images/telephone.png
delete: s3://sohiverse.cloud/images/search-icon.png
delete: s3://sohiverse.cloud/images/next.png
delete: s3://sohiverse.cloud/images/prev.png
delete: s3://sohiverse.cloud/js/bootstrap.js
delete: s3://sohiverse.cloud/images/youtube.png
delete: s3://sohiverse.cloud/images/twitter.png
delete: s3://sohiverse.cloud/js/jquery-3.4.1.min.js
delete: s3://sohiverse.cloud/index.html
delete: s3://sohiverse.cloud/images/client1.png
delete: s3://sohiverse.cloud/images/about-bg.jpg
delete: s3://sohiverse.cloud/images/facebook.png
delete: s3://sohiverse.cloud/css/style.css.map
Deleting bucket policy...
Deleting bucket website configuration...
Deleting S3 bucket...
remove_bucket: sohiverse.cloud
Cleanup completed!
Verifying cleanup...
Checking if bucket still exists...

An error occurred (NoSuchBucket) when calling the ListObjectsV2 operation: The specified bucket does not exist
Bucket deleted successfully
Checking Route 53 A record...
[
    {
        "Name": "sohiverse.cloud.",
        "Type": "NS",
    {
        "Name": "sohiverse.cloud.",
        "Type": "NS",
        "TTL": 172800,
        "ResourceRecords": [
            {
                "Value": "ns-1921.awsdns-48.co.uk."
            },
            {
                "Value": "ns-950.awsdns-54.net."
            },
            {
                "Value": "ns-306.awsdns-38.com."
            },
            {
                "Value": "ns-1218.awsdns-24.org."
            }
        ]
    },
    {
        "Name": "sohiverse.cloud.",
        "Type": "SOA",
        "TTL": 900,
        "ResourceRecords": [
            {
                "Value": "ns-1921.awsdns-48.co.uk. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400"
            }
        ]
    }
]
[cloudshell-user@ip-10-138-178-108 ~]$ 






