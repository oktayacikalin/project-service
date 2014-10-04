# Function for getting current DB connection params.
#
# @author    Oktay Acikalin <oktay.acikalin@gmail.com>
# @copyright Oktay Acikalin
# @license   MIT (LICENSE.txt)

function magento.get_db_connection_params () {
    local name="$1"
    # TODO Write a Magento script which returns the correct connection
    #      string for the requested connection.
    # TODO Finally get rid of MP_LOCAL_DBNAME.
    # echo -h"${MYSQL_HOST}" -P${MYSQL_PORT} -u"${MYSQL_USER}" -p"${MYSQL_PASS}"
    echo --defaults-extra-file="${MYSQL_ADMIN_CONF}" "${MP_LOCAL_DBNAME}"
}
