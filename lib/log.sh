# Various functions for logging messages.
#
# @author    Oktay Acikalin <oktay.acikalin@gmail.com>
# @copyright Oktay Acikalin
# @license   MIT (LICENSE.txt)

function log.log () {
    local level=$1
    local message=${@:2}
    echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')] [${level}]: ${message}"
}

function log.error () {
    log.log ERROR "$@" >&2
}

function log.warning () {
    log.log WARNING "$@" >&2
}

function log.info () {
    log.log INFO "$@" >&2
}

function log.debug () {
    log.log DEBUG "$@" >&2
}
