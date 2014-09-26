# Function for creating a database.
#
# @author    Oktay Acikalin <oktay.acikalin@gmail.com>
# @copyright Oktay Acikalin
# @license   MIT (LICENSE.txt)

function mysql.create_database () {
    local connection_params=$1
    local name=$2
    mysqladmin ${connection_params} create "${name}"
}
