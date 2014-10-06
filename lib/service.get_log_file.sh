# Function for getting the log file of a service.
#
# @author    Oktay Acikalin <oktay.acikalin@gmail.com>
# @copyright Oktay Acikalin
# @license   MIT (LICENSE.txt)

function service.get_log_file () (
    local COMMAND="NOOP"
    source "$1"
    [ "$SERVICE_LOG_FILE" ] && echo "$SERVICE_LOG_FILE"
)
