# Function for getting all commands of a service.
#
# @author    Oktay Acikalin <oktay.acikalin@gmail.com>
# @copyright Oktay Acikalin
# @license   MIT (LICENSE.txt)

function service.get_commands () {
    local service=$1
    local squote="'"
    local dquote='"'
    local commands=()
    local old_ifs="$IFS"
    local IFS=
    local includes=( $(grep -oE '^\s*source .*.service.*$' $service) )
    IFS="$old_ifs"
    if [[ "${#includes[@]}" > 0 ]] ; then
        for base in "${includes[@]}"; do
            base=($base)
            local base=$(tr -d '"' <<< ${base[1]} | tr -d "'")
            local source=${base//\$\{SERVICE_DIR\}/${SERVICE_DIR}}
            source=${source//\$\{SERVICE_ROOT_DIR\}/${SERVICE_ROOT_DIR}}
            local base_commands=($(pcregrep -o2 -M "(case .* in\n|;;)([^)]*)\)" $source | sed -e "s!#.*!!g" -e "s![$squote$dquote|\ *]! !g"))
            commands+=(${base_commands[@]})
        done
    fi
    local local_commands=($(pcregrep -o2 -M "(case .* in\n|;;)([^)]*)\)" $service | sed -e "s!#.*!!g" -e "s![$squote$dquote|\ *]! !g"))
    commands+=(${local_commands[@]})
    array.unique "${commands[@]}"
}
