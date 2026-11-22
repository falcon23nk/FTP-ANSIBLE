# FTP con Vagrant y Ansible

**Autor:** Noussayr Kordass

**Repositorio:** https://github.com/falcon23nk/FTP-ANSIBLE

## Objetivo

El objetivo de este proyecto es desplegar una infraestructura
virtualizada mediante Vagrant y automatizar la configuración
de sus servicios mediante Ansible.

Se utilizarán tres máquinas virtuales:

- dns: servidor DNS con BIND9.
- ansible: nodo controlador de Ansible.
- negocio: servidor web Apache2 y FTP seguro con vsftpd.

## Herramientas utilizadas

- Git y GitHub.
- GitHub Projects.
- VirtualBox.
- Vagrant.
- Ansible.
- Debian Bookworm.
- BIND9.
- Apache2.
- vsftpd.
- Ansible Vault.

## Requisitos

- VirtualBox.
- Vagrant.
- Git.
- Conexión a Internet para descargar las máquinas y paquetes.

## Puesta en marcha

1. Clonar el repositorio.
2. Entrar en la carpeta del proyecto.
3. Crear el archivo local vault_pass.txt con la contraseña maestra.
4. Ejecutar vagrant up.
5. Comprobar las máquinas mediante vagrant status.

## Servicios

- DNS: dns.noussayr.test
- Web: www.noussayr.test
- FTP: ftp.noussayr.test

## Autor

Noussayr Kordass


## Servicios desplegados

### DNS
- Servidor: dns.noussayr.test
- IP: 192.168.57.5
- Servicio: BIND9

### Web
- Servidor: negocio.noussayr.test
- IP: 192.168.57.7
- Nombre: www.noussayr.test
- Servicio: Apache2

### FTP
- Nombre: ftp.noussayr.test
- IP: 192.168.57.7
- Servicio: vsftpd
- Seguridad: FTP explícito sobre TLS
- Usuarios: ana y juan

## Seguridad

Las contraseñas se almacenan mediante hashes protegidos
con Ansible Vault.

El archivo vault_pass.txt está excluido del repositorio
mediante .gitignore.