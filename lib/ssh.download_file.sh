# Function for downloading via SSH and caching a file.
#
# @author    Oktay Acikalin <oktay.acikalin@gmail.com>
# @copyright Oktay Acikalin
# @license   MIT (LICENSE.txt)

function ssh.download_file () {
    local user=$1
    local host=$2
    local port=$3
    local remote_file=$4
    local local_file=$5
    local local_hash
    local remote_hash

    if [ -f "${local_file}.hash" ]; then
        remote_hash=$(ssh -o "LogLevel ERROR" -p ${port} "${user}@${host}" "md5sum ${remote_file}")
        remote_hash=$(cut -d' ' -f1 <<< "$remote_hash")
        local_hash=$(cat "${local_file}.hash")
        if [ "$local_hash" != "$remote_hash" ]; then
            rm "${local_file}" "${local_file}.hash"
        fi
    fi

    if [ ! -f "${local_file}.hash" ]; then
        echo  # Put the prompt into a new line.
        scp -o "LogLevel ERROR" -P ${port} "${user}@${host}:${remote_file}" "${local_file}"
        local local_hash=$(md5sum "${local_file}")
        local_hash=$(cut -d' ' -f1 <<< "$local_hash")
        echo "$local_hash" > "${local_file}.hash"
    fi
}
