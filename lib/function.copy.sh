# Based on: http://stackoverflow.com/a/1203628/1277498

function function.copy () {
    declare -F $1 > /dev/null || return 1
    eval "$(echo "${2}()"; declare -f ${1} | tail -n +2)"
}
