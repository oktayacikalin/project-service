var.default DNSMASQ_CONF_NAME $(sed 's![^a-zA-Z0-9]!_!g' <<< "$(basename ${BASE_DIR})")
var.default DNSMASQ_HOSTS "${ETC_DIR}/dnsmasq/hosts"
var.default DNSMASQ_CONF "${LIB_DIR}/dnsmasq/dnsmasq.conf"
var.default DNSMASQ_CONF_DIR "/etc/dnsmasq.d"
