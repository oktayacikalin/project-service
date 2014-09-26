# Function for dropping (deleting) a database.
#
# @author    Oktay Acikalin <oktay.acikalin@gmail.com>
# @copyright Oktay Acikalin
# @license   MIT (LICENSE.txt)

function mysql.drop_database () {
    local connection_params=$1
    local name=$2
    mysqladmin ${connection_params} -f drop "${name}" > /dev/null
}
