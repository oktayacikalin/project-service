# Function for finding the latest file on a remote.
#
# @link http://mywiki.wooledge.org/BashFAQ/003

import "lib/ssh.remote_cmd"

function ssh.find_latest_file () {
    local user=$1
    local host=$2
    local port=$3
    local remote_dir=$(dirname "$4")
    local remote_file=$(basename "$4")
    local latest
    local time
    while IFS= read -r -d '' line; do
      t=${line%% *} t=${t%.*}   # truncate fractional seconds
      ((t > time)) && { latest=${line#* } time=$t; }
    done < <(ssh.remote_cmd "${user}" "${host}" ${port} "find '${remote_dir}' -iname '${remote_file}' -type f -printf '%T@ %p\0'")
    echo "${latest}"
}
