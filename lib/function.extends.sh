# Function for extending another function by placing the parent as "parent"
# into the local function scope of the child. This way the child can call the
# parent any time.
#
# @author    Oktay Acikalin <oktay.acikalin@gmail.com>
# @copyright Oktay Acikalin
# @license   MIT (LICENSE.txt)

import "lib/function.rename"
import "lib/function.prepend"


function function.extends () {
    local name="$1"
    local parent
    function.rename "${name}" "__${name}"
    function.rename . "${name}"
    function.prepend "${name}" "function.rename __${name} parent"
}


# Call this in an extended function body if nothing should be done.
# (bash requires you to give at least some body. So this fixes the gap.)
function pass () {
    echo -n
}
