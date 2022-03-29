#!/bin/bash

# Start The Instance
#aws ec2 describe-instances  --query Reservations[*].Instances[*].[InstanceId,PrivateIpAddress] --output text

for instance in $(aws ec2 describe-instances  --query Reservations[*].Instances[*].[InstanceId] --output text);do
	if [ "$instance" == i-01a8847d028f413ad || "$instance" == i-00457a2c3c06eb339];
	then
		aws ec2 start-instances --instance-ids "$instance"
	fi
done

#Start the RDS
# aws rds describe-db-instances --query 'DBInstances[].DBInstanceIdentifier[]' --output text
# aws rds describe-db-instances --query 'DBInstances[].DBInstanceStatus[]' --output text
# aws rds describe-db-clusters --query 'DBClusters[].DBClusterIdentifier[]' --output text
# aws rds describe-db-clusters --query 'DBClusters[].Status[]' --output text

for rds in "database-1 database-2";do
	echo "$rds"
         if [ ! -n "$rds" ];
         then
                 echo "empty"
         else
		echo "db is there"
		for status in $(aws rds describe-db-clusters --query 'DBClusters[].Status[]' --output text);do
			echo "$status"
			if [ "$status" == "stopped" ];
			then
				echo "stopped start the RDS Instance"
				aws rds start-db-cluster --db-cluster-identifier "$rds" > /dev/null 2>&1
			else
				echo "available"
			fi
		done
	fi
done

ssh ubuntu@65.2.88.41<<EOF
 bash start.sh > /dev/null 2>&1
EOF
