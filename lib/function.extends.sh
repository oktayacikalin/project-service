# Function for extending another function by placing the parent as "parent"
# into the local function scope of the child. This way the child can call the
# parent any time.
#
# @author    Oktay Acikalin <oktay.acikalin@gmail.com>
# @copyright Oktay Acikalin
# @license   MIT (LICENSE.txt)

source "${SERVICE_ROOT_DIR}/lib/function.rename.sh"
source "${SERVICE_ROOT_DIR}/lib/function.prepend.sh"
source "${SERVICE_ROOT_DIR}/lib/function.copy.sh"


function function.extends () {
    local name="$1"
    local parent
    function.rename "${name}" "__${name}"
    function.rename . "${name}"
    function.prepend "${name}" "function.rename __${name} parent"
}

# Syntax shugar.
function.copy function.extends extends
