# Sets up important env variables for later use.
#
# @author    Oktay Acikalin <oktay.acikalin@gmail.com>
# @copyright Oktay Acikalin
# @license   MIT (LICENSE.txt)

if [ -z "${IMPORT_PATH}" ]; then
    BASE_DIR="$(readlink -f ${SERVICE_DIR}/..)"
    BIN_DIR="${BASE_DIR}/bin"
    ETC_DIR="${BASE_DIR}/etc"
    VAR_DIR="${BASE_DIR}/var"
    LIB_DIR="${BASE_DIR}/var/lib"
    LOG_DIR="${BASE_DIR}/var/log"
    PID_DIR="${BASE_DIR}/var/run"
    CACHE_DIR="${BASE_DIR}/var/cache"
    BACKUP_DIR="${BASE_DIR}/var/backups"

    IMPORT_PATH=("${BASE_DIR}" "${SERVICE_ROOT_DIR}")
    source "${SERVICE_ROOT_DIR}/lib/import.sh"
    source "${SERVICE_ROOT_DIR}/lib/log.sh"

    COMMAND="$1"

    # ASCII colors
    AC_FG_BLACK="\e[30m"
    AC_FG_RED="\e[31m"
    AC_FG_GREEN="\e[32m"
    AC_FG_YELLOW="\e[33m"
    AC_FG_BLUE="\e[34m"
    AC_FG_MAGENTA="\e[35m"
    AC_FG_CYAN="\e[36m"
    AC_FG_WHITE="\e[37m"
    AC_FG_DEFAULT="\e[39m"

    AC_BG_BLACK="\e[40m"
    AC_BG_RED="\e[41m"
    AC_BG_GREEN="\e[42m"
    AC_BG_YELLOW="\e[44m"
    AC_BG_BLUE="\e[44m"
    AC_BG_MAGENTA="\e[45m"
    AC_BG_CYAN="\e[46m"
    AC_BG_WHITE="\e[47m"

    AC_DIM="\e[2m"

    AC_RESET="\e[0m"
    AC_RESET_DIM="\e[22m"
fi
