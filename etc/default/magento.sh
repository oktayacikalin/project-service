var.default MAGENTO_HOME "${BASE_DIR}/magento"
var.default MAGENTO_CRON_PHP "cron.php"
var.default MAGENTO_SHELL_INDEXER "shell/indexer.php"
var.default MAGENTO_SHELL_MIGRATE "${SERVICE_ROOT_DIR}/scripts/magento-migrate.php"
var.default MAGENTO_SHELL_EXPORT_TRANSLATIONS "${SERVICE_ROOT_DIR}/scripts/magento-export-inline-translations.php"
var.default MAGENTO_MIGRATION_FILES "
	app/code/core/Mage/Core/Model/App.php
"
var.default MAGENTO_MIGRATION_COMMANDS "
    Mage_Core_Model_Resource_Setup::applyAllUpdates
    Mage_Core_Model_Resource_Setup::applyAllDataUpdates
"
