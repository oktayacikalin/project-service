# Function for getting the update timestamp from a table.
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


function mysql.get_table_timestamp () {
    local connection_params="$1"
    local database="$2"
    local table="$3"

    local sql="
        SELECT ENGINE, UNIX_TIMESTAMP(UPDATE_TIME) FROM TABLES
        WHERE TABLE_SCHEMA='${database}' AND TABLE_NAME='${table}';
    "
    local result=($(mysql.shell_cmd ${connection_params} -AN information_schema <<< "${sql}"))
    if [ ${#result[@]} = 0 ]; then
        log.error "Could not get stats for table: ${database}.${table}"
        exit 1
    fi

    local engine=${result[0]}
    local timestamp=${result[1]:-NULL}
    if [ "${timestamp}" != "NULL" ]; then
        echo "${timestamp}"
    else
        case "${engine}" in
            'InnoDB')
                local db_file=$(ls -rt "${MYSQL_DATA_DIR}/${database}/${table}."* | tail -n 1)
                stat --printf="%Y" "${db_file}"
            ;;

            'MyISAM')
                log.error "Update time for MyISAM table \"${database}.${table}\" not found." \
                          "Have you disabled the statistics?!"
                exit 1
            ;;

            *)
                # This applies to MEMORY and others. Here we try to at least track the structure.
                local db_file=$(ls -rt "${MYSQL_DATA_DIR}/${database}/${table}."* | tail -n 1)
                if [ -n "${db_file}" ]; then
                    stat --printf="%Y" "${db_file}"
                else
                    return 1
                fi
            ;;
        esac
    fi
}
