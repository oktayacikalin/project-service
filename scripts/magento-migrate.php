<?php

require_once 'shell/abstract.php';

/**
 * Magento shell script to execute migrations.
 *
 * @author    Oktay Acikalin <oktay.acikalin@gmail.com>
 * @copyright Oktay Acikalin
 * @license   MIT (LICENSE.txt)
 *
 */
class Shell_Migrate extends Mage_Shell_Abstract
{
    /**
     * Main entry point.
     *
     * @return void
     */
    public function run()
    {
        Mage::getConfig()->loadModules();
        Mage_Core_Model_Resource_Setup::applyAllUpdates();
        Mage_Core_Model_Resource_Setup::applyAllDataUpdates();
    }
}

$shell = new Shell_Migrate;
$shell->run();
