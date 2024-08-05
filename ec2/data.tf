data "external" "get_ec2_connect_ip" {

    program = ["python", "../ec2/get_svc_connect_ip.py"]
}