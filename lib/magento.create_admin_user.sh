# Function for creating an admin user in Magento.
#
# @author    Oktay Acikalin <oktay.acikalin@gmail.com>
# @copyright Oktay Acikalin
# @license   MIT (LICENSE.txt)

function magento.create_admin_user () {
    local username=$1
    local password=$2
    local email=$3
    local firstname=$4
    local lastname=$5
    mysql.shell_cmd $(magento.get_db_connection_params default) <<< "
        INSERT INTO admin_user SET
            username='${username}',
            password=md5('${password}'),
            email='${email}',
            firstname='${firstname}',
            lastname='${lastname}',
            is_active=1;
        SET @user_id = LAST_INSERT_ID();

        INSERT INTO admin_role SET
            parent_id=1,
            tree_level=2,
            sort_order=0,
            role_type='U',
            user_id=@user_id,
            role_name='${email}';
    "
}
