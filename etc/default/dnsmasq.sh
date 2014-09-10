var.default DNSMASQ_CONF_NAME $(sed 's![^a-zA-Z0-9]!_!g' <<< "$(basename ${BASE_DIR})")
var.default DNSMASQ_HOSTS "${BASE_DIR}/etc/dnsmasq/hosts"
var.default DNSMASQ_CONF "${VAR_DIR}/lib/dnsmasq/dnsmasq.conf"
var.default DNSMASQ_CONF_DIR "/etc/dnsmasq.d"
