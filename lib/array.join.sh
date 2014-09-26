# Function for joining given array of elements using the glu given as first param.
#
# @author    Oktay Acikalin <oktay.acikalin@gmail.com>
# @copyright Oktay Acikalin
# @license   MIT (LICENSE.txt)

function array.join () {
	local IFS="$1"
	shift
	echo "$*"
}
