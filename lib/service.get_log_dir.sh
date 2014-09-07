# Function for getting the log dir of a service.
#
# @author    Oktay Acikalin <oktay.acikalin@gmail.com>
# @copyright Oktay Acikalin
# @license   MIT (LICENSE.txt)

function service.get_log_dir () (
    source "$1" NOOP
    [ "$SERVICE_LOG_DIR" ] && echo "$SERVICE_LOG_DIR"
)
