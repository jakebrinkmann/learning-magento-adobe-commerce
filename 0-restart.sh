# After a system reboot, seems need to run these every time
cd packt1/

warden svc up
sudo systemctl restart systemd-resolved

warden env up

CERT_FILE="$HOME/.warden/ssl/certs/warden.test.crt.pem"
KEY_FILE="$HOME/.warden/ssl/certs/warden.test.key.pem"

http --verify=no GET https://app.packt1.test
http --verify=no GET https://app.packt1.test/backend
