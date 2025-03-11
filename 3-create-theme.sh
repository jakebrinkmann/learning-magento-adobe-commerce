mkdir -pv app/design/frontend/packt/theme1
cd app/design/frontend/packt/theme1

# This will create Themes in
# /backend/admin/system_design_theme/ | Content > Design > Themes
cat <<EOF | tee theme.xml
<?xml version="1.0" encoding="utf-8"?>
<theme xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:Config/etc/theme.xsd"">
    <title>Packt1 Theme</title>
    <parent>Magento/luma</parent>
</theme>
EOF

cat <<EOF | tee registration.php
<?php
use \Magento\Framework\Component\ComponentRegistrar;
ComponentRegistrar::register(
    ComponentRegistrar::THEME,
    'frontend/packt/theme1',
    __DIR__
);
EOF

ls app/design/frontend/packt/theme1/web/images/logo.svg || true

# Configure for Default (aka Global) scope (Not website, store, or view Scope)
# /backend/theme/design_config/ | Content > Design > Configuration
#   Applied Theme: <Packt1 Theme>

mkdir -p app/design/frontend/packt/theme1/web/images/
wget -O app/design/frontend/packt/theme1/web/images/logo.svg \
  https://openclipart.org/image/800px/232064
