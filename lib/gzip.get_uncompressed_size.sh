# Function for computing the final uncompressed size of all files given.
#
# @author    Oktay Acikalin <oktay.acikalin@gmail.com>
# @copyright Oktay Acikalin
# @license   MIT (LICENSE.txt)

function gzip.get_uncompressed_size () {
    gzip --list --quiet "$@" | {
        local size=0
        while read compressed uncompressed ratio filename; do
            size=$((${size} + ${uncompressed}))
        done
        echo ${size}
    }
}
