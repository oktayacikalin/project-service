# Function for getting the log file of a service.
#
# @author    Oktay Acikalin <oktay.acikalin@gmail.com>
# @copyright Oktay Acikalin
# @license   MIT (LICENSE.txt)

function service.get_log_file () (
    source "$1" NOOP
    [ "$SERVICE_LOG_FILE" ] && echo "$SERVICE_LOG_FILE"
)
