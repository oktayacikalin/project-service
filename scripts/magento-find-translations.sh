#!/bin/bash

# Tries to find given string in all csv files. Outputs filename and result.
#
# @author    Oktay Acikalin <oktay.acikalin@gmail.com>
# @copyright Oktay Acikalin
# @license   MIT (LICENSE.txt)

SEARCH="$1"

find . -iname '*.csv' -exec grep -iH "${SEARCH}" '{}' \;

