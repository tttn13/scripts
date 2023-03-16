sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get install postgresql postgresql-contrib -y

echo "PostgreSQL has been installed on the EC2 instance"
sudo su postgres
psql -c "CREATE USER ubuntu WITH SUPERUSER CREATEDB CREATEROLE PASSWORD 'password';"
exit
PG_HBA_CONF=$(sudo -u postgres psql -t -P format=unaligned -c 'show hba_file' | tr -d '[:space:]')
POSTGRESQL_CONF=$(sudo -u postgres psql -t -P format=unaligned -c 'show config_file' | tr -d '[:space:]')
echo $PG_HBA_CONF
echo $POSTGRESQL_CONF

sudo sed -i "s/host    all             all             127.0.0.1\/32            md5/host    all             all             0.0.0.0\/0               md5/g" $PG_HBA_CONF
sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" $POSTGRESQL_CONF
sudo systemctl restart postgresql