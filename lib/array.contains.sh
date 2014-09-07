# Function for checking if something is in the given array.
#
# @author    Oktay Acikalin <oktay.acikalin@gmail.com>
# @copyright Oktay Acikalin
# @license   MIT (LICENSE.txt)

function array.contains () {
    local search=$1
    local array=${@:2}
    local elm
    for elm in $array; do
        [[ "$elm" == "$search" ]] && return 0
    done
    return 1
}
