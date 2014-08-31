<?php

require_once 'shell/abstract.php';

/**
 * Magento shell script to export inline translations into the csv files.
 *
 * @author    Oktay Acikalin <oktay.acikalin@gmail.com>
 * @copyright Oktay Acikalin
 * @license   MIT (LICENSE.txt)
 *
 */
class Shell_Export_Inline_Translations extends Mage_Shell_Abstract
{
    /**
     * Cache which holds the loaded translations.
     *
     * @var array
     */
    protected $_fileCache = array();

    /**
     * Returns either the cached array, loaded array or created empty array of translations.
     *
     * @param string $filename Complete filename of the translation file.
     * @param string $fileKey  Part of the filename starting from locale.
     *
     * @return array
     */
    protected function &getTranslations($filename, $fileKey)
    {
        if (isset($this->_fileCache[$filename])) {
            return $this->_fileCache[$filename];
        }

        printf("\n%s ", $fileKey);

        $data = array();
        if (file_exists($filename)) {
            $parser = new Varien_File_Csv();
            $parser->setDelimiter(Mage_Core_Model_Translate::CSV_SEPARATOR);
            $data = $parser->getDataPairs($filename);
        }
        $this->_fileCache[$filename] = array(filename => $filename, data => $data);
        return $this->_fileCache[$filename];
    }

    /**
     * Tries to save all caches into the csv files.
     *
     * @return void
     */
    protected function saveAllTranslations()
    {
        foreach ($this->_fileCache as $cache) {
            $parser = new Varien_File_Csv();
            $csvdata = array();
            foreach ($cache['data'] as $key => $val)
                $csvdata[] = array($key, $val);
            $parser->saveData($cache['filename'], $csvdata);
        }
    }

    /**
     * Main entry point.
     *
     * @return void
     */
    public function run()
    {
        $connection = Mage::getSingleton('core/resource')->getConnection('core_read');
        $sql = 'SELECT * FROM core_translate ORDER BY locale';
        $baseDir = Mage::getBaseDir('locale');
        $dropRecords = array();

        foreach ($connection->fetchAll($sql) as $record) {
            // Extract translation data.
            list($identifier, $orgString) = explode('::', $record['string']);
            $newString = $record['translate'];
            $locale = $record['locale'];

            // Generate filename.
            $fileKey = $locale . DS . $identifier . '.csv';
            $file = $baseDir . DS . $fileKey;

            // Grab translation data.
            $cache = &$this->getTranslations($file, $fileKey);

            // Show progress.
            echo isset($cache['data'][$orgString]) ? '/' : '+';

            // Replace or add translation.
            $cache['data'][$orgString] = $newString;

            // Create SQL for drop file.
            $dropRecords[$locale][] = 'DELETE FROM core_translate WHERE key_id = ' . $record['key_id'] . ";\n";
        }

        // Write cached data back to disk.
        $this->saveAllTranslations();

        // Write drop SQL files.
        foreach ($dropRecords as $locale => $records) {
            $dropFile = Mage::getBaseDir('var') . DS . 'export' . DS . sprintf('translationDropFile-%s.sql', $locale);
            file_put_contents($dropFile, $records, FILE_APPEND | LOCK_EX);
            printf("\nAdded %d records to \"%s\".\n", count($records), $dropFile);
        }
    }
}

$shell = new Shell_Export_Inline_Translations;
$shell->run();
