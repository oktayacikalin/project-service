function assert.defined () {
    [ -z "${!1}" ] && {
        echo "$2"
        exit 1
    }
}
