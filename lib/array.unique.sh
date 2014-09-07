# Function for returning a unique and sorted array.
#
# @author    Oktay Acikalin <oktay.acikalin@gmail.com>
# @copyright Oktay Acikalin
# @license   MIT (LICENSE.txt)

function array.unique () {
    local items=($@)
    readarray -t sorted < <(printf '%s\0' "${items[@]}" | sort -zdu | xargs -0n1)
    echo "${sorted[@]}"
}
