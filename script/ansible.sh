#!/usr/bin/env bash

# Configura el servidor como nodo de control de Ansible

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
# Activaremos estas líneas cuando creemos los archivos.

cp -vf /vagrant/ansible.cfg .
cp -vf /vagrant/inventory.yml .
cp -vf /vagrant/requirements.yml .

# Establecer permisos
chown vagrant:vagrant ansible.cfg inventory.yml requirements.yml

# Instalar dependencias de Ansible
ansible-galaxy collection install -r requirements.yml

# Copiar playbooks
# Activaremos estas líneas según creemos los directorios.

cp -vrf /vagrant/dns .

chown -R vagrant:vagrant ./dns
# cp -vrf /vagrant/web .
# cp -vrf /vagrant/ftp .

# Copiar contraseña del Vault
# cp -vf /vagrant/vault_pass.txt ./.vault_pass.txt
# chmod 600 ./.vault_pass.txt

# Instalar dependencias
# ansible-galaxy collection install -r requirements.yml

# Ejecutar playbooks
# ansible-playbook dns/dns.yml
# ansible-playbook web/web.yml
# ansible-playbook ftp/ftp.yml --vault-password-file ./.vault_pass.txt