# Traps
# Honeypot Setup Script

This script sets up a honeypot network using the following tools:

* Honeyd
* Cowrie
* Dionaea
* Nginx
* Kismet

The script is for educational purposes only and should not be used for illegal or malicious activities.

## How to Use

1. Clone the repository to your local machine.
2. Run the script with the following command:


bash honeypot-setup.sh


The script will download and install the necessary dependencies, configure the honeypots, and start them.

## Configuration

The script can be configured using the following environment variables:

* **HONEYPOT_INTERFACE** - The network interface that the honeypots will listen on.
* **HONEYPOT_LOG_DIR** - The directory where the honeypot logs will be stored.
* **Kismet_INTERFACE** - The network interface that Kismet will listen on.

## Troubleshooting

If you have any problems running the script, please check the following:

* Make sure that you have the necessary dependencies installed.
* Make sure that the configuration variables are set correctly.
* Check the logs for any errors.
