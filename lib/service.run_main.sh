# Function for figuring out whether we're included or not and then run main.
#
# @author    Oktay Acikalin <oktay.acikalin@gmail.com>
# @copyright Oktay Acikalin
# @license   MIT (LICENSE.txt)

function service.run_main () (
    # echo "--- service.run_main ---"
    # echo CURRENT $0
    # echo CHAIN $CALL_CHAIN
    # echo ${BASH_SOURCE[1]}
    # echo "------------------------"
    if [ "${BASH_SOURCE[1]}" = "$0" ]; then
        main
    fi
)
