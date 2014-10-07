# Function which checks whether given choice is one of the given options.
# Throws an error message if it's empty or does not exist.
#
# @author    Oktay Acikalin <oktay.acikalin@gmail.com>
# @copyright Oktay Acikalin
# @license   MIT (LICENSE.txt)

import "lib/array.index"


function assert.valid_choice () {
    local what="$1"
    local choice="$2"
    local options=("${@:3}")
    if ! array.index "${choice}" "${options[@]}" > /dev/null; then
        log.error "Invalid ${what}. Has to be one of: ${options[@]}"
        exit 1
    fi
}