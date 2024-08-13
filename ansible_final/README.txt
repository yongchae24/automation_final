ssh n01649144@n01649144-c-vm1.canadacentral.cloudapp.azure.com
ssh n01649144@n01649144-c-vm2.canadacentral.cloudapp.azure.com
ssh n01649144@n01649144-c-vm3.canadacentral.cloudapp.azure.com

ssh n01649144@n01649144-c-vm1.canadacentral.cloudapp.azure.com "sudo yum install -y python39"
ssh n01649144@n01649144-c-vm2.canadacentral.cloudapp.azure.com "sudo yum install -y python39"
ssh n01649144@n01649144-c-vm3.canadacentral.cloudapp.azure.com "sudo yum install -y python39"

ansible linux -m ping
ansible linux -m shell -a uptime
ansible linux -m shell -a "uptime"
ansible linux -m shell -a hostname
ansible linux -m shell -a date
ansible linux -m shell -a "cat /etc/hosts"
ansible linux -m shell -a pwd
ansible linux -m shell -a "echo $PWD"
ansible linux -m shell -a 'echo "this is test file" > test_file'
ansible linux -m shell -a 'rm  test_file'

ansible-playbook -i hosts install_cifs_utils.yml
ansible-playbook -i /path/to/hosts /path/to/install_cifs_utils.yml

