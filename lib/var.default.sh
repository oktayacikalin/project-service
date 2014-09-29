# Function for setting a variable to a default value if not already set.
#
# @author    Oktay Acikalin <oktay.acikalin@gmail.com>
# @copyright Oktay Acikalin
# @license   MIT (LICENSE.txt)

function var.default () {
    [ -z "${!1}" ] && declare -rg "${1}=$2"
}