# Sets up important env variables for later use.
#
# @author    Oktay Acikalin <oktay.acikalin@gmail.com>
# @copyright Oktay Acikalin
# @license   MIT (LICENSE.txt)

BASE_DIR="$(readlink -f ${SERVICE_DIR}/..)"
VAR_DIR="${BASE_DIR}/var"
LOG_DIR="${BASE_DIR}/var/log"
PID_DIR="${BASE_DIR}/var/run"
CACHE_DIR="${BASE_DIR}/var/cache"
BACKUP_DIR="${BASE_DIR}/var/backup"
