# connect_four
Connect Four is a classic board game where players take turns trying to create a line of four of their own pieces without being blocked by their opponent.

## Installation
1. download repo
1. inside of repo root directory
    1. run `gem build connect_four.gemspec`
    1. run `gem install connect_four`
1. from anywhere on machine
    1. run `connect`

## P2P Considerations
- Ruby Code
    - Ensure that your Ruby server is listening on `0.0.0.0` instead of `localhost` or `127.0.0.1`. This will allow it to accept connections from any IP address, not just the local machine.
- Firewall Rules
    - On Linux: You can use `iptables` to open a specific port. For example, to open port 12345:
- Cloud Instance Security Groups (If Applicable)
    - If you're running your server on a cloud instance like an AWS EC2 instance, you'll also need to configure the instance's security group to allow incoming connections on the port your server is listening on.
        1. Go to the AWS EC2 Dashboard.
        1. Select your instance and navigate to its "Security Groups."
        1. Edit the inbound rules to allow TCP traffic on your port (e.g., 12345).
