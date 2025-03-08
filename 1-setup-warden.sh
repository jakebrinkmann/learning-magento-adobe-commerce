# https://docs.warden.dev/installing.html
# MacOS: brew install wardenenv/warden/warden
sudo mkdir -p /opt/warden
sudo chown $(whoami) /opt/warden
git clone -b main https://github.com/wardenenv/warden.git /opt/warden
echo 'export PATH="/opt/warden/bin:$PATH"' >>~/.$(basename ${SHELL})rc
PATH="/opt/warden/bin:$PATH"

warden svc up

# https://docs.warden.dev/configuration/dns-resolver.html
# MacOS: cat /etc/resolver/test
sudo mkdir -p /etc/systemd/resolved.conf.d
echo -e "[Resolve]\nDNS=127.0.0.1\nDomains=~test\n" |
    sudo tee /etc/systemd/resolved.conf.d/warden.conf >/dev/null
sudo systemctl restart systemd-resolved

# ❯ ls ~/.warden/ssl/certs
# warden.test.crt.pem  warden.test.csr.pem  warden.test.key.pem
CERT_FILE="$HOME/.warden/ssl/certs/warden.test.crt.pem"
KEY_FILE="$HOME/.warden/ssl/certs/warden.test.key.pem"
# sudo cp "$CERT_FILE" /usr/local/share/ca-certificates/
# sudo update-ca-certificates
sudo cp "$CERT_FILE" /etc/ssl/certs/
sudo c_rehash

http GET https://traefik.warden.test
http GET https://portainer.warden.test
http GET https://dnsmasq.warden.test
http GET https://webmail.warden.test

mkdir packt1
cd packt1

warden env-init packt1 magento2
# cat ./.env
#   WARDEN_ENV_NAME=packt1
#   WARDEN_ENV_TYPE=magento2
#   WARDEN_WEB_ROOT=/
warden sign-certificate packt1.test

# https://commercemarketplace.adobe.com/customer/accessKeys/
composer global config http-basic.repo.magento.com <username> <password>
# ~/auth.json << { "http-basic": {"repo.magento.com": {"username": "", "password": ""}}}

META_PACKAGE=magento/project-community-edition META_VERSION=2.4.7-p4
composer create-project --repository-url=https://repo.magento.com/ \
    "${META_PACKAGE}" /tmp/exampleproject "${META_VERSION}" \
  && rsync -a /tmp/exampleproject/ ./ \
  && rm -rf /tmp/exampleproject/

warden env up

false && warden env down -v
