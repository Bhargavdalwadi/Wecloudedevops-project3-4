import boto3

ec2 = boto3.resource('ec2')
custom_filter=[{'Name': 'tag:Project','Values': ['devops-command-center']}]


for instance in ec2.instances.filter(Filters=custom_filter):
    print( "Id: {0}\n \nPublic IPv4: {1}\nAMI: {2}\nState:{3} \n".format(instance.id, instance.public_ip_address, instance.image.id, instance.state))
