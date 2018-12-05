# awscli
## 前提
事前に以下実施すること
aws configure --profile ${profile}
### route53
```
aws route53 list-hosted-zones --query HostedZones[].Name --output table --profile ${profile}
```
### ec2
```
# list instance
aws ec2 describe-instances --query 'Reservations[].Instances[].[Tags[?Key==`Name`].Value|[0],PrivateIpAddress,PublicIpAddress,InstanceId]' --output table --profile ${profile}

```

# aws acount for lab
```
export AWS_ACCESS_KEY_ID=${access_key}
export AWS_SECRET_ACCESS_KEY=${secret_key}
export AWS_DEFAULT_REGION=ap-northeast-1
```
