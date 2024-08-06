data "external" "get_ec2_connect_ip" {

    program = ["python3", "../ec2/get_svc_connect_ip.py"]
}