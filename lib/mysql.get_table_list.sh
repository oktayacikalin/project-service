# Function for getting a list of table names for a database.
#
# It bets and depends on the following situation:
# * InnoDB tables are file per table and local.
# * MyISAM tables are updating its stats properly.
# * Other types can be ignored.
#
# @author    Oktay Acikalin <oktay.acikalin@gmail.com>
# @copyright Oktay Acikalin
# @license   MIT (LICENSE.txt)

import 'lib/mysql.shell_cmd'


function mysql.get_table_list () {
    local connection_params="$1"
    local database="$2"

    local sql="
        SELECT TABLE_NAME FROM TABLES
        WHERE TABLE_SCHEMA='${database}';
    "
    local result=($(mysql.shell_cmd ${connection_params} -AN information_schema <<< "${sql}"))
    if [ ${#result[@]} = 0 ]; then
        log.error "Could not get list of tables for database: ${database}"
        exit 1
    fi
    echo "${result[@]}"
}
