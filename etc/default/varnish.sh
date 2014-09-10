var.default VARNISH_PID "${PID_DIR}/varnishd.pid"
var.default VARNISH_LIB "${VAR_DIR}/lib/varnish"
var.default VARNISH_VCL "${BASE_DIR}/etc/varnish/varnish.vcl"
var.default VARNISH_MEM "malloc,10M"
var.default VARNISH_HOST "${BASE_DOMAIN}"
var.default VARNISH_PORT 7002
var.default VARNISH_PARAMS vcl_dir="${BASE_DIR}/etc/varnish"
