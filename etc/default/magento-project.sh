# var.default MP_REMOTE_TYPE "ssh"
var.default MP_REMOTE_USER "anonymous"
var.default MP_REMOTE_HOST "magento.somewhere.com"
var.default MP_REMOTE_PORT 22
var.default MP_REMOTE_FILE "backups/magento-*.sql.gz"

var.default MP_TRUNCATABLE_TABLES "
    catalog_compare_item
    core_cache
    core_cache_tag
    core_session
    dataflow_batch_export
    dataflow_batch_import
    enterprise_admin_passwords
    index_event
    index_process_event
    log_customer
    log_quote
    log_summary
    log_summary_type
    log_url
    log_url_info
    log_visitor
    log_visitor_info
    log_visitor_online
    enterprise_logging_event
    enterprise_logging_event_changes
    report_compared_product_index
    report_event
    report_viewed_product_index
    sales_payment_transaction
"

# TODO Implement additional step which truncates these.
# TODO Implement additional step which reindexes these.
var.default MP_TRUNCATABLE_INDEX_TABLES "
    catalog_category_flat_store_1
    catalog_category_flat_store_2
    catalog_category_flat_store_3
    catalog_category_flat_store_4
    catalog_category_flat_store_5
    catalog_category_flat_store_6
    catalog_category_flat_store_7
    catalog_category_flat_store_8
    catalog_category_flat_store_9
    catalog_product_flat_0
    catalog_product_flat_1
    catalog_product_flat_2
    catalog_product_flat_3
    catalog_product_flat_4
    catalog_product_flat_5
    catalog_product_flat_6
    catalog_product_flat_7
    catalog_product_flat_8
    catalog_product_flat_9
"

# TODO Will be obsolete as soon as we can query Magento for the correct connection params.
var.default MP_LOCAL_DBNAME "magento"

var.default MP_ANON_CUSTOMER_PASSWORD "password"
var.default MP_ANON_ADMIN_USERNAME "admin"
var.default MP_ANON_ADMIN_PASSWORD "password"

# Get the IP via host command.
# var.default MP_BASE_DOMAIN_IP $(grep "${BASE_DOMAIN}" ${ETC_DIR}/dnsmasq/hosts | cut -d' ' -f1)
var.default MP_BASE_DOMAIN_IP $(host "${BASE_DOMAIN}" | tail -n1 | cut -d' ' -f4)

# See magento.service for possible reindex-* commands.
var.default MP_REINDEX_MODE "reindex-search"
