var.default REDIS_PID "${PID_DIR}/redis.pid"
var.default REDIS_HOST "${BASE_DOMAIN}"
var.default REDIS_PORT "6002"
var.default REDIS_LOG "${LOG_DIR}/redis.log"
var.default REDIS_CONFIG "
daemonize yes
pidfile \"$REDIS_PID\"
bind $REDIS_HOST
port $REDIS_PORT
logfile \"$REDIS_LOG\"
dir \"${LIB_DIR}/redis\"
"
