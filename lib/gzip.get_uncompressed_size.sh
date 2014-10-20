# Function for computing the final uncompressed size of all files given.
#
# @author    Oktay Acikalin <oktay.acikalin@gmail.com>
# @copyright Oktay Acikalin
# @license   MIT (LICENSE.txt)

function gzip.get_uncompressed_size () {
    local sizes=($(gzip --list --quiet "$@" | {
        while read compressed uncompressed ratio filename; do
            echo $uncompressed
        done
    }))
    local size=0
    for bytes in "${sizes[@]}"; do
        size=$(($size + $bytes))
    done
    echo $size
}
