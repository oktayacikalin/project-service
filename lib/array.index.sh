# Function for returning the pos of the given item in the array.
#
# @author    Oktay Acikalin <oktay.acikalin@gmail.com>
# @copyright Oktay Acikalin
# @license   MIT (LICENSE.txt)

function array.index () {
    local search=$1
    local array=("${@:2}")
    for (( i = 0; i < ${#array[@]}; i++ )); do
        if [ "${array[$i]}" = "${search}" ]; then
            echo $i;
            return 0
        fi
    done
    return 1
}
