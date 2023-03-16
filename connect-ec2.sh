#IMPORTANT: make this script executable by running chmod +x ./connect-ec2.sh in ur terminal

# Prompt the user for input
echo "Enter the relative KEY_PATH of the pem file: "
read input
KEY_PATH=$input
echo "Enter the EC2 IPv4 address: "
read input
EC2_IP=$input
chmod 400 $KEY_PATH
ssh -i "$KEY_PATH" ubuntu@"$EC2_IP"
echo "You are connected to EC2 instance"
