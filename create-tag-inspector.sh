#/bin/bash
# ==============================
# Usage
#  ./create-tag-inspector.sh <profile>
#  引数にaws configureでつけたprofile名を記載して実行
# 例：
#  ./create-tag-inspector.sh xxx
#  ./create-tag-inspector.sh yyy
#
# もくろみ：
#  tagにstgがつくインスタンスにinspector用のカスタムタグを追加したかった
#===============================

grepkey="stg"

profile=$1
list="stg-instanceid.list"
key="inspector"
val="True"


aws ec2 describe-instances \
--query 'Reservations[].Instances[].[Tags[?Key==`Name`].Value|[0],InstanceId]' \
--output text \
--profile ${profile} \
| grep ${grepkey} | awk '{print $2}' > ${list}

for INSTANCE_ID in `cat ${list}`
do
	echo ${INSTANCE_ID}
	aws ec2 create-tags --tag Key=${key},Value=${val} --profile ${profile} --resources ${INSTANCE_ID}
done

exit 0
