var.default VARNISH_PID "${PID_DIR}/varnishd.pid"
var.default VARNISH_LIB "${LIB_DIR}/varnish"
var.default VARNISH_VCL "${ETC_DIR}/varnish/varnish.vcl"
var.default VARNISH_MEM "malloc,10M"
var.default VARNISH_HOST "${BASE_DOMAIN}"
var.default VARNISH_PORT 7002
var.default VARNISH_PARAMS vcl_dir="${ETC_DIR}/varnish"
