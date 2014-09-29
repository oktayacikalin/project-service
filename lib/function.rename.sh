# Based on: http://stackoverflow.com/a/10682418/1277498

function function.rename () {
    local old_name=$1
    local new_name=$2
    eval "$(echo "${new_name}()"; declare -f ${old_name} | tail -n +2)"
    unset -f ${old_name}
}
