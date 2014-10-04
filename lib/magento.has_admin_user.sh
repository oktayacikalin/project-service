# Function for checking the existance of an admin user in Magento.
#
# @author    Oktay Acikalin <oktay.acikalin@gmail.com>
# @copyright Oktay Acikalin
# @license   MIT (LICENSE.txt)

function magento.has_admin_user () {
    local username=$1
    sql="SELECT username FROM admin_user WHERE username='${MP_ANON_ADMIN_USERNAME}';"
    output=$(mysql.shell_cmd $(magento.get_db_connection_params default) <<< "${sql}")
    [ -z "${output}" ] && return 1 || return 0
}
