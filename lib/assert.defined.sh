# Function which checks a variable by given name and exits with code 1 and given
# message if it's empty or does not exist.
#
# @author    Oktay Acikalin <oktay.acikalin@gmail.com>
# @copyright Oktay Acikalin
# @license   MIT (LICENSE.txt)

function assert.defined () {
    [ -z "${!1}" ] && {
        log.error "$2"
        exit 1
    }
}
