# Based on: http://stackoverflow.com/a/10682418/1277498

function function.append () {
    local name=$1
    shift
    local body="$@"
    eval "$(declare -f ${name} | head -n -1; echo ${body}; echo '}')"
}
