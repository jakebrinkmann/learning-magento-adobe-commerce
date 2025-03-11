tree vendor/magento/module-catalog/etc/
# vendor/magento/module-catalog/etc/
# ├── acl.xml
# ├── adminhtml
# │   ├── di.xml
# │   ├── events.xml
# │   ├── menu.xml
# │   ├── routes.xml
# │   └── system.xml
# ├── catalog_attributes.xml
# ├── catalog_attributes.xsd
# ├── communication.xml
# ├── config.xml
# ├── crontab.xml
# ├── db_schema_whitelist.json
# ├── db_schema.xml
# ├── di.xml
# ├── eav_attributes.xml
# ├── events.xml
# ├── extension_attributes.xml
# ├── frontend
# │   ├── di.xml
# │   ├── events.xml
# │   ├── page_types.xml
# │   ├── routes.xml
# │   └── sections.xml
# ├── indexer.xml
# ├── module.xml
# ├── mview.xml
# ├── product_options_merged.xsd
# ├── product_options.xml
# ├── product_options.xsd
# ├── product_types_base.xsd
# ├── product_types_merged.xsd
# ├── product_types.xml
# ├── product_types.xsd
# ├── queue_consumer.xml
# ├── queue_publisher.xml
# ├── queue_topology.xml
# ├── queue.xml
# ├── view.xml
# ├── webapi_async.xml
# ├── webapi_rest
# │   └── di.xml
# ├── webapi_soap
# │   └── di.xml
# ├── webapi.xml
# └── widget.xml

cat app/etc/env.php
#     'cache' => [
#         'graphql' => [
#             'id_salt' => 'CAPcd5Nmi0lAVswWdb9QhaeyyPlGJFMR'
#         ],
#         'frontend' => [
#             'default' => [
#                 'id_prefix' => '69d_',
#                 'backend' => 'Magento\\Framework\\Cache\\Backend\\Redis',
#                 'backend_options' => [
#                     'server' => 'redis',
#                     'database' => '0',
#                     'port' => '6379',
#                     'password' => '',
#                     'compress_data' => '1',
#                     'compression_lib' => '',
#                     '_useLua' => true,
#                     'use_lua' => false
#                 ]
#             ],
#             'page_cache' => [
#                 'id_prefix' => '69d_',
#                 'backend' => 'Magento\\Framework\\Cache\\Backend\\Redis',
#                 'backend_options' => [
#                     'server' => 'redis',
#                     'database' => '1',
#                     'port' => '6379',
#                     'password' => '',
#                     'compress_data' => '0',
#                     'compression_lib' => ''
#                 ]
#             ]
#         ],
#         'allow_parallel_generation' => false
#     ],

bin/magento cache:status
# Current status:
#                         config: 1    // XML + GraphQL + config.php + Admin
#                         layout: 1    // Pages
#                     block_html: 0    // Cached PHTML blocks (if enabled)
#                    collections: 1    // DB fetch results
#                     reflection: 1    // API interfaces
#                         db_ddl: 1    // DB DDL
#                compiled_config: 1    // code compliation
#                            eav: 1    // entity type declaration
#          customer_notification: 1
#             config_integration: 1
#         config_integration_api: 1
#  graphql_query_resolver_result: 1
#                      full_page: 0    // **IMPORTANT** entire HTML output (varnish or redis)
#              config_webservice: 1
#                      translate: 1

bin/magento cache:clean config full_page # clears by tags, recommended
bin/magento cache:flush config full_page

bin/magento cache:disable block_html layout full_page

# Clears pub/static and var/cache
bin/magento deploy:mode:set developer
