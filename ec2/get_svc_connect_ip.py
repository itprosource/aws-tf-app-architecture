import boto3
import requests
import json
import re

# Read the AWS region from the Terraform AWS provider block configuration
terraform_config_file = '../module/main.tf'

with open(terraform_config_file, 'r') as file:
    terraform_config = file.read()

region_pattern = r'region\s*=\s*"([\w-]+)"'
region_match = re.search(region_pattern, terraform_config)

if region_match:
    aws_region = region_match.group(1)
else:
    raise ValueError("AWS region not found in the Terraform configuration.")

# Fetch the IP ranges JSON data from AWS
response = requests.get('https://ip-ranges.amazonaws.com/ip-ranges.json')
ip_ranges = response.json()

# Filter the IP ranges for the service "EC2_INSTANCE_CONNECT" in the specified region
ec2_instance_connect_ip = None

for prefix in ip_ranges['prefixes']:
    if prefix['service'] == 'EC2_INSTANCE_CONNECT' and prefix['region'] == aws_region:
        ec2_instance_connect_ip = prefix['ip_prefix']
        break

if ec2_instance_connect_ip is None:
    raise ValueError(f"No IP range found for EC2_INSTANCE_CONNECT in region {aws_region}")
else:
    print(json.dumps({'ec2_connect_ip': str(ec2_instance_connect_ip)}))
