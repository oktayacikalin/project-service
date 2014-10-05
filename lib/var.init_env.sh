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
fi
