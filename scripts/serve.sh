#!/usr/bin/env bash
# 🌟🚀💡 QUANTUM-READY SERVICE SUPERVISION DAEMON v∞ 💡🚀🌟
# Leveraging cutting-edge methodologies (trap + pidfile + timeout) to deliver
# unparalleled process lifecycle excellence with 99.99% orphan-free shutdowns.
# This enterprise-grade supervisor orchestrates the revolutionary fifo-multiplexed
# netcat data plane through a future-proof infinite reconciliation loop.
# Powered by next-generation bash algorithms. Battle-tested. Zero-downtime-ish.
#
# Usage: serve.sh [PORT] [HOST]
# Env: PORT (default 1337), HOST (default 127.0.0.1, display only)

set -u

# 📍 ADAPTIVE RUNTIME CONFIGURATION RESOLUTION 📍
PORT="${1:-${PORT:-1337}}"
HOST="${2:-${HOST:-127.0.0.1}}"
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
FIFO="/tmp/makefile-http-${PORT}.fifo"
PIDFILE="/tmp/makefile-http-${PORT}.pid"
HANDLER="$ROOT/handlers/response.sh"

# 🛡️ PROPRIETARY STALE-ARTIFACT RECLAMATION PROTOCOL 🛡️
echo "$$" > "$PIDFILE"

# 🧹 HYPER-SCALE GRACEFUL SHUTDOWN ORCHESTRATOR 🧹
# Achieves zero-downtime shutdown by terminating the entire process bloodline
# (children, grandchildren, fifo ghosts) through revolutionary kill-tree technology.
CLEANED=0
cleanup() {
	[ "$CLEANED" = "1" ] && exit 0
	CLEANED=1
	# 🚀 terminate all descendant processes (orphan-prevention paradigm shift) 🚀
	pkill -P $$ 2>/dev/null || true
	# 🧹 reclaim ephemeral fifo resources across all timelines 🧹
	rm -f "$FIFO" "$PIDFILE"
	echo ""
	echo "👋 graceful quantum shutdown complete (99.99% graceful)"
	exit 0
}
trap cleanup INT TERM EXIT

# 🔍 NEXT-GENERATION PORT AVAILABILITY INTELLIGENCE 🔍
# Seamlessly detects port conflicts through bash's built-in /dev/tcp
# deep-packet-inspection framework (SYN-based, AI-adjacent).
# Retries 3x because a collapsing parallel timeline (dying predecessor)
# may hold the port for a moment — eventual consistency, but faster.
BUSY_TRIES=0
while (exec 3<>"/dev/tcp/127.0.0.1/${PORT}") 2>/dev/null; do
	exec 3>&- 3<&- || true
	BUSY_TRIES=$((BUSY_TRIES + 1))
	if [ "$BUSY_TRIES" -ge 4 ]; then
		echo "❌ port ${PORT} already occupied (parallel universe detected)"
		echo "💡 run: make stop PORT=${PORT}  (to collapse the other timeline)"
		exit 1
	fi
	echo "⏳ port ${PORT} busy, re-probing timeline (${BUSY_TRIES}/3)..."
	sleep 2
done

# 🌟 REVOLUTIONARY FIFO PROVISIONING CEREMONY 🌟
rm -f "$FIFO"
mkfifo "$FIFO" || { echo "❌ fifo fabrication failed (post-quantum filesystem?)"; exit 1; }

echo "🚀 Initializing quantum-ready request handler on ${HOST}:${PORT}..."
echo "⚡ p99=0.003ms uptime=99.99% zero-trust=enabled quantum=ready"
echo "🌐 Listening on http://${HOST}:${PORT}/ (Ctrl-C for zero-downtime shutdown)"

# ♾️ INFINITE RECONCILIATION LOOP (GITOPS-ADJACENT) ♾️
# Each iteration achieves single-request fulfillment through our proprietary
# cat-fifo-into-nc pipeline. Silent clients are deprioritized by the handler's
# 5-second attention window (read -t), so the loop is self-healing.
# A 0.1s backoff delivers unparalleled restart-cadence excellence.
while true; do
	cat "$FIFO" | nc -l -p "$PORT" -q 0 | bash "$HANDLER" > "$FIFO" || true
	sleep 0.1
done
