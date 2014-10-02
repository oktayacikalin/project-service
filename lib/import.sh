# Function for importing a file by searching the IMPORT_PATH.
#
# @author    Oktay Acikalin <oktay.acikalin@gmail.com>
# @copyright Oktay Acikalin
# @license   MIT (LICENSE.txt)

source "${SERVICE_ROOT_DIR}/lib/function.copy.sh"
source "${SERVICE_ROOT_DIR}/lib/array.contains.sh"

__IMPORTED=("lib/function.copy" "lib/array.contains" "lib/import")


function import () {
    local what="$1"
    local modifier="${2}"
    local argument="$3"
    local filename
    for import_path in "${IMPORT_PATH[@]}"; do
        filename="${import_path}/${what}.sh"
        if [ -f "${filename}" ]; then
            if ! array.contains "${what}" "${__IMPORTED[@]}"; then
                source "${filename}"
                __IMPORTED+=("${what}")
            fi
            if [ "${modifier}" = "as" ]; then
                if [ "${what%%/*}" != "lib" ]; then
                    echo "ERROR: Can only load libs with alias name. Got: ${what} -> ${argument}"
                    exit 1
                fi
                function.copy "${what##*/}" "${argument}"
            elif [ -n "${modifier}" ]; then
                echo "ERROR: Unknown modifier \"${modifier}\" for import: ${what}"
                exit 1
            fi
            return 0
        fi
    done
    echo "ERROR: Could not find: ${what}"
}
