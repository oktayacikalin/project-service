# Function for adding ASCII colors to a given command.
#
# @author    Oktay Acikalin <oktay.acikalin@gmail.com>
# @copyright Oktay Acikalin
# @license   MIT (LICENSE.txt)

function service.colorize_command () {
    local command="${command}"
    local color=""
    if [[ "${command}" =~ "start" ]] || [[ "${command}" =~ "restart" ]] || [[ "${command}" =~ "reload" ]] || [[ "${command}" =~ "stop" ]]; then
        color="${AC_FG_GREEN}"
    elif [[ "${command}" =~ "init-script" ]]; then
        color="${AC_FG_BLUE}"
    elif [[ "${command}" =~ "install" ]]; then
        color="${AC_FG_RED}"
    elif [[ "${command}" =~ "shell" ]]; then
        color="${AC_FG_MAGENTA}"
    elif [[ "${command}" =~ "cache" ]]; then
        color="${AC_FG_CYAN}"
    elif [[ "${command}" =~ "tail" ]] || [[ "${command}" =~ "help" ]]; then
        color="${AC_DIM}"
    fi
    echo "${color}${command}${AC_RESET_DIM}${AC_FG_DEFAULT}"
}
