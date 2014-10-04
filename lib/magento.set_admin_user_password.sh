# Function for setting an admin user password in Magento.
#
# @author    Oktay Acikalin <oktay.acikalin@gmail.com>
# @copyright Oktay Acikalin
# @license   MIT (LICENSE.txt)

function magento.set_admin_user_password () {
    local username=$1
    local password=$2
    mysql.shell_cmd $(magento.get_db_connection_params default) <<< "
        UPDATE admin_user SET password=md5('${password}'), is_active=1 WHERE username='${MP_ANON_ADMIN_USERNAME}';
    "
}
