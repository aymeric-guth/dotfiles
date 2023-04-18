#!/bin/sh

# check AWS_EC2_ID is defined
# check AWS_KEY_PATH is defined

_aws-check() {
  [ -z "$AWS_EC2_ID" ] && {
		echo 'AWS_EC2_ID is not defined'
		return 1
	}
  [ -z "$AWS_KEY_FILE" ] && {
		echo 'AWS_KEY_FILE is not defined'
		return 1
	}
  return 0
}

_aws-instance-ip() {
	_ip=$(aws ec2 describe-instances --instance-ids $AWS_EC2_ID --query 'Reservations[].Instances[].PublicIpAddress' --output text)
	[ -z "$_ip" ] && {
		echo 'ec2 instance is not up'
		return 1
	}
	echo "$_ip"
	return 0
}

aws-ssh() {
  _aws-check || return 1
	_ip=$(_aws-instance-ip) || { echo "$_ip" && return 1; }

	ssh \
		-o "ConnectTimeout 3" \
		-o "StrictHostKeyChecking no" \
		-o "UserKnownHostsFile /dev/null" \
		-i "$AWS_KEY_FILE" \
		ubuntu@"$_ip"
}


# aws ec2 describe-instances --instance-ids i-09aca61e074db3e10 --query 'Reservations[].Instances[].PublicIpAddress' --output text

aws-stop() {
  _aws-check || return 1
	aws \
    ec2 \
    stop-instances \
    --instance-ids \
    "$AWS_EC2_ID"
}

aws-start() {
	aws \
    ec2 \
    start-instances \
    --instance-ids \
    "$AWS_EC2_ID"
}

aws-bill() {
	aws \
    ce \
    get-cost-and-usage \
    --time-period Start=$(date -u +"%Y-%m-01"),End=$(date -u +"%Y-%m-%d") \
    --granularity MONTHLY \
    --metrics "UnblendedCost"
}

aws-status() {
	aws \
    ec2 \
    describe-instances \
    --filters "Name=instance-state-name,Values=running"
}

aws-scp() {
	_ip=$(_aws-instance-ip) || { echo "$_ip" && return 1; }
	scp \
    -i "$AWS_KEY_FILE" ubuntu@"$_ip" "$@"
}
