# var.default MP_REMOTE_TYPE "ssh"
var.default MP_REMOTE_USER "anonymous"
var.default MP_REMOTE_HOST "magento.somewhere.com"
var.default MP_REMOTE_PORT 22
var.default MP_REMOTE_FILE "backups/magento-*.sql.gz"

var.default MP_TRUNCATABLE_TABLES "
    catalog_compare_item
    core_cache
    dataflow_batch_export
    dataflow_batch_import
    enterprise_admin_passwords
    index_event
    log_customer
    log_quote
    log_summary
    log_summary_type
    log_url
    log_url_info
    log_visitor
    log_visitor_info
    log_visitor_online
    report_compared_product_index
    report_event
    report_viewed_product_index
    sales_payment_transaction
"
# TODO Also truncate table data of the flat indexers, which will
#      rebuild the data later on anyway.

# TODO Will be obsolete as soon as we can query Magento for the correct connection params.
var.default MP_LOCAL_DBNAME "magento"

var.default MP_ANON_CUSTOMER_PASSWORD "password"
var.default MP_ANON_ADMIN_USERNAME "admin"
var.default MP_ANON_ADMIN_PASSWORD "password"

var.default MP_BASE_DOMAIN_IP $(grep "${BASE_DOMAIN}" ${ETC_DIR}/dnsmasq/hosts | cut -d' ' -f1)

# Manage the solr installation and configuration? 0=no, 1=yes
var.default MP_SOLR_MANAGE 0
var.default MP_SOLR_MAGENTO_CONF_PATH "${MAGENTO_HOME}/lib/Apache/Solr/conf"
var.default MP_SOLR_MAGENTO_LINK_MODE "copy"
# var.default MP_SOLR_MAGENTO_LINK_MODE "symlink"
var.default MP_SOLR_DEFAULT_CORE_NAME "default"
