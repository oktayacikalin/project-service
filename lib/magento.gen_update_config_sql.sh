# Function for generating an update config SQL statement.
#
# @author    Oktay Acikalin <oktay.acikalin@gmail.com>
# @copyright Oktay Acikalin
# @license   MIT (LICENSE.txt)

function magento.gen_update_config_sql () {
    local path=$1
    local value=$2
    local scope=${3-default}
    local scope_id=${4-0}
    echo "UPDATE core_config_data SET value='${value}'" \
         "WHERE path='${path}' AND scope='${scope}' AND scope_id=${scope_id};"
}
