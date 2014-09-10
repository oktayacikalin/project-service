function var.default () {
    [ -z "${!1}" ] && declare -rg "${1}=$2"
}