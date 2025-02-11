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
echo -e "[Resolve]\nDNS=127.0.0.1\nDomains=~test\n" \
  | sudo tee /etc/systemd/resolved.conf.d/warden.conf > /dev/null
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
warden env-init packt1 magento2
# cat ./.env
#   WARDEN_ENV_NAME=packt1
#   WARDEN_ENV_TYPE=magento2
#   WARDEN_WEB_ROOT=/
warden sign-certificate packt1.test

warden env up

false && warden env down -v

warden shell

composer global config http-basic.repo.magento.com <username> <password>

META_PACKAGE=magento/project-community-edition META_VERSION=2.4.x

composer create-project --repository-url=https://repo.magento.com/ \
    "${META_PACKAGE}" /tmp/exampleproject "${META_VERSION}"

rsync -a /tmp/exampleproject/ /var/www/html/
rm -rf /tmp/exampleproject/

 ## Install Application
 bin/magento setup:install \
     --backend-frontname=backend \
     --amqp-host=rabbitmq \
     --amqp-port=5672 \
     --amqp-user=guest \
     --amqp-password=guest \
     --db-host=db \
     --db-name=magento \
     --db-user=magento \
     --db-password=magento \
     --search-engine=opensearch \
     --opensearch-host=opensearch \
     --opensearch-port=9200 \
     --opensearch-index-prefix=magento2 \
     --opensearch-enable-auth=0 \
     --opensearch-timeout=15 \
     --http-cache-hosts=varnish:80 \
     --session-save=redis \
     --session-save-redis-host=redis \
     --session-save-redis-port=6379 \
     --session-save-redis-db=2 \
     --session-save-redis-max-concurrency=20 \
     --cache-backend=redis \
     --cache-backend-redis-server=redis \
     --cache-backend-redis-db=0 \
     --cache-backend-redis-port=6379 \
     --page-cache=redis \
     --page-cache-redis-server=redis \
     --page-cache-redis-db=1 \
     --page-cache-redis-port=6379

 ## Configure Application
 bin/magento config:set --lock-env web/unsecure/base_url \
     "https://${TRAEFIK_SUBDOMAIN}.${TRAEFIK_DOMAIN}/"

 bin/magento config:set --lock-env web/secure/base_url \
     "https://${TRAEFIK_SUBDOMAIN}.${TRAEFIK_DOMAIN}/"

 bin/magento config:set --lock-env web/secure/offloader_header X-Forwarded-Proto

 bin/magento config:set --lock-env web/secure/use_in_frontend 1
 bin/magento config:set --lock-env web/secure/use_in_adminhtml 1
 bin/magento config:set --lock-env web/seo/use_rewrites 1

 bin/magento config:set --lock-env system/full_page_cache/caching_application 2
 bin/magento config:set --lock-env system/full_page_cache/ttl 604800

 bin/magento config:set --lock-env catalog/search/enable_eav_indexer 1

 bin/magento config:set --lock-env dev/static/sign 0

 bin/magento deploy:mode:set -s developer
 bin/magento cache:disable block_html full_page

 bin/magento indexer:reindex
 bin/magento cache:flush

 ## Generate localadmin user
 ADMIN_PASS="$(pwgen -n1 16)"
 ADMIN_USER=localadmin

 bin/magento admin:user:create \
     --admin-password="${ADMIN_PASS}" \
     --admin-user="${ADMIN_USER}" \
     --admin-firstname="Local" \
     --admin-lastname="Admin" \
     --admin-email="${ADMIN_USER}@example.com"
 printf "u: %s\np: %s\n" "${ADMIN_USER}" "${ADMIN_PASS}"

 ## Configure 2FA provider
 OTPAUTH_QRI=
 # Python 2: TFA_SECRET=$(python -c "import base64; print base64.b32encode('$(pwgen -A1 128)')" | sed 's/=*$//')
 # Python 3:
 TFA_SECRET=$(python3 -c "import base64; print(base64.b32encode(bytearray('$(pwgen -A1 128)', 'ascii')).decode('utf-8'))" | sed 's/=*$//')
 OTPAUTH_URL=$(printf "otpauth://totp/%s%%3Alocaladmin%%40example.com?issuer=%s&secret=%s" \
     "${TRAEFIK_SUBDOMAIN}.${TRAEFIK_DOMAIN}" "${TRAEFIK_SUBDOMAIN}.${TRAEFIK_DOMAIN}" "${TFA_SECRET}"
 )

 bin/magento config:set --lock-env twofactorauth/general/force_providers google
 bin/magento security:tfa:google:set-secret "${ADMIN_USER}" "${TFA_SECRET}"

 printf "%s\n\n" "${OTPAUTH_URL}"
 printf "2FA Authenticator Codes:\n%s\n" "$(oathtool -s 30 -w 10 --totp --base32 "${TFA_SECRET}")"

 segno "${OTPAUTH_URL}" -s 4 -o "pub/media/${ADMIN_USER}-totp-qr.png"
 printf "%s\n\n" "https://${TRAEFIK_SUBDOMAIN}.${TRAEFIK_DOMAIN}/media/${ADMIN_USER}-totp-qr.png?t=$(date +%s)"
