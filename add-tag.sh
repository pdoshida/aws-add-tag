#/bin/bash
# ==============================
# Usage
#  ./create-tag-inspector.sh <profile> <key> <val> <grepkey>
#  引数にaws configureでつけたprofile名を記載して実行
#
# 例：
#  ./add-tag.sh lab Inspector True stg
#  ./add-tag.sh test Backup True prd
#
# もくろみ：
#  tagにstgがつくインスタンスにinspector用のカスタムタグを追加したかった
# ===============================

profile=$1
key=$2
val=$3
grepkey=$4

list="tmp.list"


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

rm ${list}

exit 0
