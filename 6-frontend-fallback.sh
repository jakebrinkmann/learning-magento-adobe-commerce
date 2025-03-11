cd pub/static/frontend/packt/theme1/en_US/images
ls -lsha
# total 12K
# 4.0K drwxrwxr-x  2 www-data www-data 4.0K Mar 10 23:13 .
# 4.0K drwxrwxr-x 28 www-data www-data 4.0K Mar 10 23:13 ..
#    0 lrwxrwxrwx  1 www-data www-data   41 Mar 10 23:13 loader-1.gif -> /var/www/html/lib/web/images/loader-1.gif
# 4.0K lrwxrwxrwx  1 www-data www-data   66 Mar 10 23:24 logo.svg -> /var/www/html/app/design/frontend/packt/theme1/web/images/logo.svg

cd ../
ls -lsha
# total 148K
# 4.0K drwxrwxr-x 28 www-data www-data 4.0K Mar 10 23:13 .
# 4.0K drwxrwxr-x  3 www-data www-data 4.0K Mar 10 23:13 ..
# 4.0K drwxrwxr-x  4 www-data www-data 4.0K Mar 10 23:13 Magento_Captcha
# 4.0K drwxrwxr-x  3 www-data www-data 4.0K Mar 10 23:13 Magento_Catalog
# 4.0K drwxrwxr-x  4 www-data www-data 4.0K Mar 10 23:13 Magento_Checkout
# 4.0K drwxrwxr-x  4 www-data www-data 4.0K Mar 10 23:13 Magento_Customer
# 4.0K drwxrwxr-x  3 www-data www-data 4.0K Mar 10 23:13 Magento_Msrp
# 4.0K drwxrwxr-x  3 www-data www-data 4.0K Mar 10 23:13 Magento_PageBuilder
# 4.0K drwxrwxr-x  3 www-data www-data 4.0K Mar 10 23:13 Magento_PageCache
# 4.0K drwxrwxr-x  3 www-data www-data 4.0K Mar 10 23:13 Magento_PaypalCaptcha
# 4.0K drwxrwxr-x  3 www-data www-data 4.0K Mar 10 23:13 Magento_Persistent
# 4.0K drwxrwxr-x  3 www-data www-data 4.0K Mar 10 23:13 Magento_ReCaptchaFrontendUi
# 4.0K drwxrwxr-x  3 www-data www-data 4.0K Mar 10 23:13 Magento_ReCaptchaWebapiUi
# 4.0K drwxrwxr-x  3 www-data www-data 4.0K Mar 10 23:13 Magento_Search
# 4.0K drwxrwxr-x  3 www-data www-data 4.0K Mar 10 23:13 Magento_Security
# 4.0K drwxrwxr-x  3 www-data www-data 4.0K Mar 10 23:13 Magento_Tax
# 4.0K drwxrwxr-x  3 www-data www-data 4.0K Mar 10 23:13 Magento_Theme
# 4.0K drwxrwxr-x  3 www-data www-data 4.0K Mar 10 23:13 Magento_Translation
# 4.0K drwxrwxr-x  5 www-data www-data 4.0K Mar 10 23:13 Magento_Ui
# 4.0K drwxrwxr-x  2 www-data www-data 4.0K Mar 10 23:13 css
# 4.0K drwxrwxr-x  3 www-data www-data 4.0K Mar 10 23:13 fonts
# 4.0K drwxrwxr-x  2 www-data www-data 4.0K Mar 10 23:13 images
# 4.0K drwxrwxr-x  5 www-data www-data 4.0K Mar 10 23:13 jquery
#    0 lrwxrwxrwx  1 www-data www-data   31 Mar 10 23:13 jquery.js -> /var/www/html/lib/web/jquery.js
# 4.0K drwxrwxr-x  2 www-data www-data 4.0K Mar 10 23:13 js-cookie
# 4.0K drwxrwxr-x  2 www-data www-data 4.0K Mar 10 23:13 js-storage
# 4.0K -rw-rw-r--  1 www-data www-data    2 Mar 10 23:13 js-translation.json
# 4.0K drwxrwxr-x  2 www-data www-data 4.0K Mar 10 23:13 knockoutjs
# 4.0K drwxrwxr-x  6 www-data www-data 4.0K Mar 10 23:13 mage
#    0 lrwxrwxrwx  1 www-data www-data   35 Mar 10 23:13 matchMedia.js -> /var/www/html/lib/web/matchMedia.js
#    0 lrwxrwxrwx  1 www-data www-data   31 Mar 10 23:13 moment.js -> /var/www/html/lib/web/moment.js
# 4.0K drwxrwxr-x  2 www-data www-data 4.0K Mar 10 23:13 requirejs
#  32K -rw-rw-r--  1 www-data www-data  32K Mar 10 23:13 requirejs-config.js
#    0 lrwxrwxrwx  1 www-data www-data   35 Mar 10 23:13 underscore.js -> /var/www/html/lib/web/underscore.js

cd /var/www/html/
mv app/design/frontend/packt/theme1/web/images/logo{,.old}.svg

bin/magento deploy:mode:set developer # clear cache
curl -X GET https://app.packt1.test   # force symlinks

# Looks for the file:
# 1. theme folder
# 2. parent (parent's parent, etc.) theme folder
# 3. module file

cd pub/static/frontend/packt/theme1/en_US/images
ls -lsha
# total 12K
# 4.0K drwxrwxr-x  2 www-data www-data 4.0K Mar 10 23:32 .
# 4.0K drwxrwxr-x 28 www-data www-data 4.0K Mar 10 23:32 ..
#    0 lrwxrwxrwx  1 www-data www-data   41 Mar 10 23:32 loader-1.gif -> /var/www/html/lib/web/images/loader-1.gif
# 4.0K lrwxrwxrwx  1 www-data www-data   68 Mar 10 23:32 logo.svg -> /var/www/html/vendor/magento/theme-frontend-luma/web/images/logo.svg

cd -
cd pub/static/frontend/packt/theme1/en_US/css/
ls -lsha
# total 528K
# 4.0K drwxrwxr-x  2 www-data www-data 4.0K Mar 10 23:32 .
# 4.0K drwxrwxr-x 28 www-data www-data 4.0K Mar 10 23:32 ..
# 4.0K -rw-rw-r--  1 www-data www-data 1.7K Mar 10 23:32 print.css
#  92K -rw-rw-r--  1 www-data www-data  89K Mar 10 23:32 styles-l.css
# 424K -rw-rw-r--  1 www-data www-data 423K Mar 10 23:32 styles-m.css

cd -
cat vendor/magento/theme-frontend-blank/Magento_Theme/layout/default_head_blocks.xml
# <?xml version="1.0"?>
# <!--
# /**
#  * Copyright © Magento, Inc. All rights reserved.
#  * See COPYING.txt for license details.
#  */
# -->
# <page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
#     <head>
#         <css src="css/styles-m.css"/>
#         <css src="css/styles-l.css" media="screen and (min-width: 768px)"/>
#         <css src="css/print.css" media="print"/>
#         <meta name="format-detection" content="telephone=no"/>
#     </head>
# </page>

mkdir -p app/design/frontend/packt/theme1/web/css/source/
cp vendor/magento/theme-frontend-luma/web/css/source/_theme.less \
  app/design/frontend/packt/theme1/web/css/source/_theme.less

cat <<EOF | tee -a app/design/frontend/packt/theme1/web/css/source/_theme.less
body img {
  border: 2px solid black;
  padding: 10px;
}
EOF

bin/magento deploy:mode:set developer # clear cache

cp package.json.sample package.json
cp Gruntfile.js.sample Gruntfile.js
npm install
grunt
# Running "default" task
#
# I'm default task and at the moment I'm empty, sorry :/
#
# Done.
#
#
# Execution Time (2025-03-10 23:43:47 UTC-0)
# loading tasks  117ms  ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 98%
# default          2ms  ▇▇ 2%
# Total 119ms

grunt exec
# [ ... ]
# Done.
#
#
# Execution Time (2025-03-10 23:44:10 UTC-0)
# loading tasks  83ms  ▇▇ 1%
# exec:blank     1.4s  ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 20%
# exec:luma      1.3s  ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 18%
# exec:backend   1.4s  ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 19%
# exec:all       3.1s  ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 42%
# Total 7.3s

vi dev/tools/grunt/configs/themes.js
#    packt1: {
#        area: 'frontend',
#        name: 'packt/theme1',
#        locale: 'en_US',
#        files: [
#            'css/styles-m',
#            'css/styles-l'
#        ],
#        dsl: 'less'
#    }

grunt exec
# Execution Time (2025-03-10 23:49:58 UTC-0)
# exec:blank    1.3s  ▇▇▇▇▇▇▇▇▇▇▇▇▇ 13%
# exec:luma     1.4s  ▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 13%
# exec:backend  1.4s  ▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 13%
# exec:packt1   1.8s  ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 17%
# exec:all      4.4s  ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 43%
# Total 10.4s

grunt watch:packt1
