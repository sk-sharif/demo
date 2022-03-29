#!/bin/bash

ssh ubuntu@65.2.88.41<<EOF
 bash stop.sh > /dev/null 2>&1
EOF

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
				echo "stopped"
			else
				echo "available"
				aws rds stop-db-cluster --db-cluster-identifier "$rds" > /dev/null 2>&1
			fi
		done
	fi
done

#aws ec2 describe-instances  --query Reservations[*].Instances[*].[InstanceId,PrivateIpAddress] --output text

for instance in $(aws ec2 describe-instances  --query Reservations[*].Instances[*].[InstanceId] --output text);do
#        if [ "$instance" == $(hostname -I | awk '{print $1}') ];
#        then
#                echo "$instance"
#                aws ec2 stop-instances --instance-ids $(aws ec2 describe-instances --filter Name=private-ip-address,Values="$instance" --query 'Reservations[].Instances[].InstanceId' --output text)
#        fi
	if [ "$instance" == i-01a8847d028f413ad ] || [ "$instance" == i-00457a2c3c06eb339 ];
	then
		aws ec2 stop-instances --instance-ids "$instance"
	fi
done
