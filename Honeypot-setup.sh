#!/usr/bin/env python3

import os
import sys

# Exit immediately if any command fails

def main():
    # Check for necessary dependencies
    if not all([
        os.path.exists("/usr/bin/honeyd"),
        os.path.exists("/usr/bin/cowrie"),
        os.path.exists("/usr/bin/dionaea"),
        os.path.exists("/usr/sbin/nginx"),
        os.path.exists("/usr/bin/kismet-ng"),
    ]):
        print("Error: one or more dependencies are not installed.")
        sys.exit(1)

    # Update the system and install necessary dependencies
    print("Updating system and installing dependencies...")
    os.system("sudo apt-get update")
    os.system("sudo apt-get -y upgrade")
    os.system("sudo apt-get -y install honeyd cowrie dionaea nginx kismet-ng")

    # Configure and start honeyd
    print("Configuring honeyd...")
    with open("/etc/honeyd/honeyd.conf", "w") as f:
        f.write("""
create 192.168.1.1
add 192.168.1.1 http server apache
set 192.168.1.1 personality "Windows XP SP2"
bind 192.168.1.1
""")
    os.system("sudo systemctl enable honeyd")
    os.system("sudo systemctl start honeyd")

    # Configure and start cowrie
    print("Configuring cowrie...")
    with open("/etc/cowrie/cowrie.cfg", "w") as f:
        f.write("""
[ssh]
enabled = true
listen_endpoints = tcp:22:interface=0.0.0.0
""")
    os.system("sudo systemctl enable cowrie")
    os.system("sudo systemctl start cowrie")

    # Configure and start dionaea
    print("Configuring dionaea...")
    with open("/etc/dionaea/dionaea.cfg", "w") as f:
        f.write("""
[modules]
nfqnl_os = yes
nfqnl_dorkbot = yes
nfqnl_mws = yes
[python]
enabled = yes
modules = all
""")
    os.system("sudo systemctl enable dionaea")
    os.system("sudo systemctl start dionaea")

    # Configure and start nginx to serve the honeypot logs
    print("Configuring nginx...")
    with open("/etc/nginx/sites-available/honeypot", "w") as f:
        f.write("""
server {
    listen 80;
    server_name honeypot.example.com;
    root /var/log/honeypot;
    index index.html;
    location / {
        autoindex on;
    }
}
""")
    os.system("sudo ln -sf /etc/nginx/sites-available/honeypot /etc/nginx/sites-enabled/")
    os.system("sudo nginx -t")
    os.system("sudo systemctl reload nginx")

    # Configure and start Kismet
    print("Configuring Kismet...")
    with open("/etc/kismet/kismet.conf", "w") as f:
        f.write("""
interface=eth0
""")
    os.system("sudo systemctl enable kismet")
    os.system("sudo systemctl start kismet")

    print("Done! Honeypots are up and running.")

if __name__ == "__main__":
    main()
