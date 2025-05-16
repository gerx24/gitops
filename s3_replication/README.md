Production

Production_role: replication-source-role
Bucket: gerx24-source-bucket
aws s3api get-bucket-versioning --bucket gerx24-source-bucket
{
    "Status": "Enabled"
}

aws iam simulate-principal-policy \
  --policy-source-arn arn:aws:iam::1111111111111111:role/replication-source-role \
  --action-names s3:GetObject s3:ReplicateObject \
  --resource-arns "arn:aws:s3:::gerx24-source-bucket/*" "arn:aws:s3:::gerx24-destination-bucket/*" \
  --output json  > prod-output.json

aws s3api get-bucket-replication --bucket gerx24-source-bucket
{
    "ReplicationConfiguration": {
        "Role": "arn:aws:iam::1111111111111111:role/replication-source-role",
        "Rules": [
            {
                "ID": "cross-replication",
                "Priority": 0,
                "Filter": {},
                "Status": "Enabled",
                "SourceSelectionCriteria": {
                    "ReplicaModifications": {
                        "Status": "Enabled"
                    }
                },
                "Destination": {
                    "Bucket": "arn:aws:s3:::gerx24-destination-bucket",
                    "Account": "222222222222",
                    "StorageClass": "STANDARD",
                    "AccessControlTranslation": {
                        "Owner": "Destination"
                    }
                },
                "DeleteMarkerReplication": {
                    "Status": "Disabled"
                }
            }
        ]
    }
}

aws s3api get-bucket-encryption --bucket gerx24-source-bucket                                                                                           ─╯
{
    "ServerSideEncryptionConfiguration": {
        "Rules": [
            {
                "ApplyServerSideEncryptionByDefault": {
                    "SSEAlgorithm": "AES256"
                },
                "BucketKeyEnabled": false
            }
        ]
    }
}

aws iam get-role-policy --role-name replication-source-role --policy-name source-replication-policy


Test:

echo "test" > we_made_it_100.txt
aws s3 cp we_made_it_100.txt s3://gerx24-source-bucket/

aws s3api head-object --bucket gerx24-source-bucket --key we_made_it_100.txt.txt

aws s3api copy-object \
  --bucket gerx24-source-bucket \
  --copy-source gerx24-source-bucket/gerson_germoral_test_7.txt \
  --key gerson_germoral_test_7.txt


===================================================================================================================================================================
INTEGRATION:
Bucket: gerx24-destination-bucket
aws s3api get-bucket-versioning --bucket gerx24-destination-bucket

{
    "Status": "Enabled"
}

aws s3api get-bucket-policy --bucket gerx24-destination-bucket

{
    "Policy": "{\"Version\":\"2012-10-17\",\"Id\":\"\",\"Statement\":[{\"Sid\":\"AllowReplicationFromPROD\",\"Effect\":\"Allow\",\"Principal\":{\"AWS\":\"arn:aws:iam::1111111111111111:role/replication-source-role\"},\"Action\":[\"s3:ReplicateObject\",\"s3:ReplicateDelete\",\"s3:ReplicateTags\"],\"Resource\":\"arn:aws:s3:::gerx24-destination-bucket/*\"}]}"
}

aws s3api get-bucket-encryption --bucket gerx24-destination-bucket                                                                                            ─╯
{
    "ServerSideEncryptionConfiguration": {
        "Rules": [
            {
                "ApplyServerSideEncryptionByDefault": {
                    "SSEAlgorithm": "AES256"
                },
                "BucketKeyEnabled": false
            }
        ]
    }
}

aws s3api get-bucket-policy --bucket gerx24-destination-bucket

aws s3 ls s3://gerx24-destination-bucket/

