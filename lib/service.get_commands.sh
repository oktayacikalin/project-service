# Function for getting all commands of a service.
#
# @author    Oktay Acikalin <oktay.acikalin@gmail.com>
# @copyright Oktay Acikalin
# @license   MIT (LICENSE.txt)

function service.get_commands () {
    local service=$1
    local pattern_a="'[^']+'"
    local pattern_b='"[^"]+"'
    local squote="'"
    local dquote='"'
    local commands=()
    local includes
    readarray -t includes <<< $(grep -oE '^\s*source .*.service.*$' $service)
    if [ "${includes[@]}" ] ; then
        for base in "${includes[@]}"; do
            base=($base)
            local base=$(tr -d '"' <<< ${base[1]} | tr -d "'")
            local source=${base//\$\{SERVICE_DIR\}/${SERVICE_DIR}}
            local base_commands=($(grep -oE "^\s+($pattern_a|$pattern_b)\)" $source |
                                 sed "s![$squote$dquote]!!g" | tr -d ' ' | cut -d')' -f1))
            commands+=(${base_commands[@]})
        done
    fi
    local local_commands=($(grep -oE "^\s+($pattern_a|$pattern_b)\)" $service |
                          sed "s![$squote$dquote]!!g" | tr -d ' ' | cut -d')' -f1))
    commands+=(${local_commands[@]})
    array.unique "${commands[@]}"
}
