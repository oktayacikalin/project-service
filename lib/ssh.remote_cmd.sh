# Function for running a remote command.
#
# @author    Oktay Acikalin <oktay.acikalin@gmail.com>
# @copyright Oktay Acikalin
# @license   MIT (LICENSE.txt)

function ssh.remote_cmd () {
    local user=$1
    local host=$2
    local port=$3
    local cmd=$4
    ssh -o "LogLevel ERROR" -p ${port} "${user}@${host}" -- ${cmd}
}
