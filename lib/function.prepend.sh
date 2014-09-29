# Based on: http://stackoverflow.com/a/10682418/1277498

function function.prepend () {
    local name=$1
    shift
    local body="$@"
    eval "$(echo "${name}(){"; echo ${body}; declare -f ${name} | tail -n +3)"
}
