#!/usr/bin/env bash

# Configurar el nodo controlador de Ansible

set -xeu

cd /home/vagrant

# Instalar herramientas necesarias
apt-get update
apt-get install -y ansible ansible-lint whois curl bind9-dnsutils

# Crear directorio de claves privadas
mkdir -p ./private_keys

# Copiar las claves privadas de Vagrant
cp -vf /vagrant/.vagrant/machines/dns/virtualbox/private_key \
    ./private_keys/dns.key.rsa

cp -vf /vagrant/.vagrant/machines/negocio/virtualbox/private_key \
    ./private_keys/negocio.key.rsa

# Configurar permisos de las claves
chown vagrant:vagrant ./private_keys/*
chmod 600 ./private_keys/*

# Copiar configuración de Ansible
cp -vf /vagrant/ansible.cfg .
cp -vf /vagrant/inventory.yml .
cp -vf /vagrant/requirements.yml .

# Asignar permisos de configuración
chown vagrant:vagrant ansible.cfg inventory.yml requirements.yml

# Copiar carpetas de los servicios
cp -vrf /vagrant/dns .
cp -vrf /vagrant/web .
cp -vrf /vagrant/ftp .

# Asignar propietarios después de copiar
chown -R vagrant:vagrant ./dns
chown -R vagrant:vagrant ./web
chown -R vagrant:vagrant ./ftp

# Comprobar que existe la contraseña de Vault
if [ ! -f /vagrant/vault_pass.txt ]; then
    echo "ERROR: No existe vault_pass.txt"
    exit 1
fi

# Copiar contraseña de Vault
cp -vf /vagrant/vault_pass.txt ./.vault_pass.txt

# Configurar permisos
chown vagrant:vagrant ./.vault_pass.txt
chmod 600 ./.vault_pass.txt

# Instalar colecciones necesarias
ansible-galaxy collection install -r requirements.yml

# Comprobar conexión con los servidores
ansible all -m ping

# Ejecutar playbook DNS
ansible-playbook dns/dns.yml

# Ejecutar playbook web
ansible-playbook web/web.yml

# Ejecutar playbook FTP
ansible-playbook ftp/ftp.yml \
    --vault-password-file ./.vault_pass.txt