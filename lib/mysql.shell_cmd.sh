# Function for executing the client command.
# Can also be used to pipe in SQL commands (e.g. for importing).
#
# @author    Oktay Acikalin <oktay.acikalin@gmail.com>
# @copyright Oktay Acikalin
# @license   MIT (LICENSE.txt)

function mysql.shell_cmd () {
    local connection_params=$1
    mysql ${connection_params} "${@:2}"
}
