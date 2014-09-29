# Function which waits until the PID in the given file shows up.
#
# @author    Oktay Acikalin <oktay.acikalin@gmail.com>
# @copyright Oktay Acikalin
# @license   MIT (LICENSE.txt)

function proc.wait_for_pid_in_file () {
    local pid_file="$1"
    if [ ! -f "${pid_file}" ]; then
        echo "ERROR: Pid file does not exist: ${pid_file}"
        exit 1
    fi

    local pid=$(cat ${pid_file})

    while true; do
        local proc=$(ps xaww | grep -v grep | grep mysqld | grep ${pid})
        if [ -n "$proc" ]; then
            break
        fi
        sleep 1
        echo -n "."
    done
}
