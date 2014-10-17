# Function which waits until the PID in the given file and process shows up.
#
# @author    Oktay Acikalin <oktay.acikalin@gmail.com>
# @copyright Oktay Acikalin
# @license   MIT (LICENSE.txt)

function proc.wait_for_pid_in_file () {
    local pid_file="$1"
    local timeout="${2:-30}"
    local got_dots=0
    local i
    for (( i=0; i < ${timeout}; i++ )); do
        if [ ! -f "${pid_file}" ]; then
            sleep 1
            echo -n "."
            got_dots=1
        fi
    done

    if [ ! -f "${pid_file}" ]; then
        echo "ERROR: Pid file does not exist: ${pid_file}"
        exit 1
    fi

    local pid=$(cat ${pid_file})
    local proc
    for (( i=0; i < ${timeout}; i++ )); do
        proc=$(ps -x -o pid | grep "${pid}")
        if [ -n "$proc" ]; then
            break
        fi
        sleep 1
        echo -n "."
        got_dots=1
    done
    if [ "${got_dots}" = 1 ]; then
        echo -n " "
    fi
}
