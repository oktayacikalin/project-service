# Function which checks whether given dir exists and exits with code 1 and given
# message if not.
#
# @author    Oktay Acikalin <oktay.acikalin@gmail.com>
# @copyright Oktay Acikalin
# @license   MIT (LICENSE.txt)

function assert.is_dir () {
    if [ ! -d "${1}" ]; then
        log.error "${2}"
        exit 1
    fi
}
