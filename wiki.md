# awscli
## 前提
事前に以下実施すること
aws configure --profile ${profile}

or 以下実施すればprofileオプション不要
```
export AWS_ACCESS_KEY_ID="xxxxxxxxxxxx"
export AWS_SECRET_ACCESS_KEY="yyyyyyyyyyy"
export AWS_DEFAULT_REGION="ap-northeast-1"
export AWS_DEFAULT_OUTPUT="json"
```

### route53
```
aws route53 list-hosted-zones --query HostedZones[].Name --output table --profile ${profile}
```
### ec2
```
# ec2 list
aws ec2 describe-instances \
  --query 'Reservations[].Instances[].[Tags[?Key==`Name`].Value|[0],PrivateIpAddress,PublicIpAddress,InstanceId]' \
  --output table \
  --profile ${profile}

# ec2 create tag
aws ec2 create-tags --resources ${INSTANCE_ID} --tag Key=Name,Value=${NAME}
```
### iam
```
# user delete
aws iam delete-login-profile --user-name shigyo --profile ${profile}

```
