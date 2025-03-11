crontab -l

bin/magento cron:install
# Crontab has been generated and saved

crontab -l
#
# #~ MAGENTO START 69dd2b02e1f3a65918182048ea4e29979a849d8942e8f53ed20a4bf10e529b36
# * * * * * /usr/bin/php /var/www/html/bin/magento cron:run 2>&1 | grep -v "Ran jobs by schedule" >> /var/www/html/var/log/magento.cron.log
# #~ MAGENTO END 69dd2b02e1f3a65918182048ea4e29979a849d8942e8f53ed20a4bf10e529b36

bin/magento index:status
# +----------------------------------+---------------------------+--------+-----------+---------------------+---------------------+
# | ID                               | Title                     | Status | Update On | Schedule Status     | Schedule Updated    |
# +----------------------------------+---------------------------+--------+-----------+---------------------+---------------------+
# | catalogrule_product              | Catalog Product Rule      | Ready  | Schedule  | idle (0 in backlog) | 2025-03-10 00:47:09 |
# | catalogrule_rule                 | Catalog Rule Product      | Ready  | Schedule  | idle (0 in backlog) | 2025-03-10 00:47:09 |
# | catalogsearch_fulltext           | Catalog Search            | Ready  | Schedule  | idle (0 in backlog) | 2025-03-10 00:47:12 |
# | catalog_category_product         | Category Products         | Ready  | Schedule  | idle (0 in backlog) | 2025-03-10 00:47:07 |
# | customer_grid                    | Customer Grid             | Ready  | Schedule  | idle (0 in backlog) | 2025-03-10 00:47:06 |
# | design_config_grid               | Design Config Grid        | Ready  | Schedule  | idle (0 in backlog) | 2025-03-10 00:47:06 |
# | inventory                        | Inventory                 | Ready  | Schedule  | idle (0 in backlog) | 2025-03-10 00:47:08 |
# | catalog_product_category         | Product Categories        | Ready  | Schedule  | idle (0 in backlog) | 2025-03-10 00:47:07 |
# | catalog_product_attribute        | Product EAV               | Ready  | Schedule  | idle (0 in backlog) | 2025-03-10 00:47:08 |
# | catalog_product_price            | Product Price             | Ready  | Schedule  | idle (0 in backlog) | 2025-03-10 00:47:09 |
# | sales_order_data_exporter        | Sales Order Feed          | Ready  | Schedule  | idle (0 in backlog) | 2025-03-10 00:47:12 |
# | sales_order_status_data_exporter | Sales Order Statuses Feed | Ready  | Schedule  | idle (0 in backlog) | 2025-03-10 00:47:12 |
# | cataloginventory_stock           | Stock                     | Ready  | Schedule  | idle (0 in backlog) | 2025-03-10 00:47:09 |
# | store_data_exporter              | Stores Feed               | Ready  | Schedule  | idle (0 in backlog) | 2025-03-10 00:47:12 |
# +----------------------------------+---------------------------+--------+-----------+---------------------+---------------------+

bin/magento index:set-mode realtime
# Index mode for Indexer Design Config Grid was changed from 'Update by Schedule' to 'Update on Save'
# Index mode for Indexer Customer Grid was changed from 'Update by Schedule' to 'Update on Save'
# Index mode for Indexer Category Products was changed from 'Update by Schedule' to 'Update on Save'
# Index mode for Indexer Product Categories was changed from 'Update by Schedule' to 'Update on Save'
# Index mode for Indexer Catalog Rule Product was changed from 'Update by Schedule' to 'Update on Save'
# Index mode for Indexer Product EAV was changed from 'Update by Schedule' to 'Update on Save'
# Index mode for Indexer Inventory was changed from 'Update by Schedule' to 'Update on Save'
# Index mode for Indexer Catalog Product Rule was changed from 'Update by Schedule' to 'Update on Save'
# Index mode for Indexer Stock was changed from 'Update by Schedule' to 'Update on Save'
# Index mode for Indexer Product Price was changed from 'Update by Schedule' to 'Update on Save'
# Index mode for Indexer Catalog Search was changed from 'Update by Schedule' to 'Update on Save'
# Index mode for Indexer Sales Order Feed has not been changed
# Index mode for Indexer Sales Order Statuses Feed has not been changed
# Index mode for Indexer Stores Feed has not been changed

bin/magento indexer:reindex
bin/magento indexer:reset # ensures a re-index will take plac

bin/magento setup:upgrade # ensures installation is up-to-date with codebase & db schema

bin/magento setup:static-content:deploy
#  NOTE: Manual static content deployment is not required in "default" and "developer" modes.
#  In "default" and "developer" modes static contents are being deployed automatically on demand.
#  If you still want to deploy in these modes, use -f option: 'bin/magento setup:static-content:deploy -f'
