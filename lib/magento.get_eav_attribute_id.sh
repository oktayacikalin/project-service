# Function for getting the EAV attribute ID of given type and code.
#
# @author    Oktay Acikalin <oktay.acikalin@gmail.com>
# @copyright Oktay Acikalin
# @license   MIT (LICENSE.txt)

function magento.get_eav_attribute_id () {
    local entity_type_code=$1
    local attribute_code=$2
    SQL="
    SELECT attribute_id
    FROM eav_attribute
    WHERE entity_type_id = (
        SELECT entity_type_id FROM eav_entity_type WHERE entity_type_code = '${entity_type_code}' LIMIT 1
    ) AND attribute_code = '${attribute_code}' LIMIT 1
    "
    local id=$(mysql.shell_cmd $(magento.get_db_connection_params default) -B -N <<< "${SQL}")
    [ -z "${id}" ] && echo 0 || echo "${id}"
}
