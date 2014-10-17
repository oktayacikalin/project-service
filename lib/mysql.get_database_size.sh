# Function for estimating the size of a database.
#
# @author    Oktay Acikalin <oktay.acikalin@gmail.com>
# @copyright Oktay Acikalin
# @license   MIT (LICENSE.txt)

function mysql.get_database_size () {
    local connection_params=$1
    local name=$2
    # FIXME: Estimated size is slightly too small (about 10%).
    local sql="
    SELECT SUM(data_length + index_length)
    FROM information_schema.TABLES
    WHERE table_schema='${name}' GROUP BY table_schema;
    "
    mysql.shell_cmd ${connection_params} -AN <<< "${sql}"
}
