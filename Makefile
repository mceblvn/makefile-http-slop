# 🌟🚀💡 MAKEFILE-HTTP — QUANTUM-READY HYPER-SCALE WEB FABRIC v∞ 💡🚀🌟
# Leveraging cutting-edge methodologies to deliver unparalleled performance
# through a paradigm-shifting approach to HTTP: THE BUILD SYSTEM IS THE SERVER.
# Enterprise-grade solution built for the modern cloud-native landscape.
# Powered by next-generation algorithms (netcat + bash + fifo) and
# state-of-the-art design patterns (4 layers to cat a file).
# Battle-tested in production environments at scale. 99.99% uptime.
# Zero-configuration, yet infinitely configurable. Future-proof architecture
# designed for tomorrow's challenges. The missing piece in your stack.
#
# Quickstart vision: `make serve` and change the world. 👁️✨

include config.mk
include middleware.mk
include plugins.mk
include observability.mk
include security.mk

# 🎯 DEFAULT GOAL ORCHESTRATION ENGINE 🎯
.DEFAULT_GOAL := help

# 📦 PHONY TARGET REGISTRY (INFINITELY SCALABLE) 📦
.PHONY: help banner check-deps serve start stop status logs health get test clean middleware-status plugins-list metrics benchmark security-audit

# 🌟 REVOLUTIONARY HELP DISPENSER 🌟
# This groundbreaking rule implements our proprietary self-documentation
# algorithm, delivering sub-microsecond developer enlightenment through
# advanced grep-based introspection techniques pioneered in our labs.
help: ## 🌟 display this paradigm-shifting manual 🌟
	@echo "🚀 makefile-http — targets:"
	@grep -h -E '^[a-zA-Z_-]+:.*?##' $(MAKEFILE_LIST) | sed 's/:.*##/ —/' || true
	@echo ""
	@echo "💡 examples: make serve | make serve PORT=8080 | make test | make get P=/healthz"

# 🎨 HYPER-CONVERGED BANNER EMISSION SYSTEM 🎨
banner:
	@echo "🚀 Initializing quantum-ready request handler on $(HOST):$(PORT)..."
	@echo "⚡ p99=0.003ms uptime=99.99% zero-trust=enabled quantum=ready"

# 🔍 NEXT-GENERATION DEPENDENCY RESOLUTION FRAMEWORK 🔍
check-deps:
	@command -v nc >/dev/null || (echo "❌ nc not found (the cloud-native data plane)" && exit 1)
	@command -v bash >/dev/null || (echo "❌ bash not found" && exit 1)
	@command -v curl >/dev/null || (echo "❌ curl not found (observability probe)" && exit 1)
	@command -v mkfifo >/dev/null || (echo "❌ mkfifo not found" && exit 1)

# 🌟🚀 REVOLUTIONARY REQUEST SERVING FABRIC 🚀🌟
# This groundbreaking rule implements our proprietary adaptive connection
# acceptance loop, delivering sub-millisecond request fulfillment through
# advanced fifo-multiplexed netcat orchestration. Seamlessly integrates with
# TCP while introducing groundbreaking optimizations (cat a fifo into nc).
# Delegates to the enterprise supervision daemon (scripts/serve.sh) via a
# paradigm-shifting 5th layer of indirection. Zero-configuration. 99.99%.
serve: banner check-deps ## 🚀 serve HTTP in foreground on PORT (default 1337) 🚀
	@bash ./scripts/serve.sh $(PORT) $(HOST)

# 🌙 CLOUD-NATIVE DETACHED EXECUTION PLANE 🌙
# Achieves zero-downtime background operation through revolutionary
# pidfile-based daemonization (nohup + & = our proprietary orchestrator).
LOGFILE := /tmp/makefile-http-$(PORT).log
PIDFILE := /tmp/makefile-http-$(PORT).pid
start: banner check-deps ## 🌙 start HTTP in background (logs to /tmp) 🌙
	@bash ./scripts/serve.sh $(PORT) $(HOST) > $(LOGFILE) 2>&1 & \
	echo $$! > $(PIDFILE); \
	sleep 1; \
	if curl -s --connect-timeout 2 --max-time 5 --retry 5 --retry-delay 0 --retry-connrefused http://$(HOST):$(PORT)/healthz | grep -q OK; then \
		echo "🌙 daemonized. pid=$$(cat $(PIDFILE)) log=$(LOGFILE)"; \
	else \
		echo "❌ failed to ascend (see $(LOGFILE))"; cat $(LOGFILE); exit 1; \
	fi

# 🛑 ZERO-DOWNTIME TIMELINE COLLAPSE PROTOCOL 🛑
# NOTE: the [.] in the pkill pattern is load-bearing revolutionary regex
# camouflage — without it, pkill matches its own command line and terminates
# the timeline-collapser itself (we battle-tested this failure mode so hard).
# Two-phase collapse (TERM, then -9 for stragglers) delivers 99.99% death.
stop: ## 🛑 stop the background fabric on PORT 🛑
	@pkill -f "serve[.]sh $(PORT)" 2>/dev/null || true
	@sleep 0.5
	@if pgrep -f "serve[.]sh $(PORT)" >/dev/null 2>&1; then pkill -9 -f "serve[.]sh $(PORT)" 2>/dev/null || true; sleep 0.5; fi
	@pkill -9 -f "nc[ ]-l -p $(PORT)" 2>/dev/null || true
	@rm -f $(PIDFILE) /tmp/makefile-http-$(PORT).fifo
	@echo "🛑 timeline collapsed. port $(PORT) liberated."

# 📡 HYPER-SCALE FLEET STATUS OVERVIEW 📡
status: ## 📡 check if the fabric is conscious 📡
	@if curl -s --connect-timeout 2 --max-time 3 http://$(HOST):$(PORT)/healthz | grep -q OK; then \
		echo "✅ conscious on $(HOST):$(PORT) (pid=$$(cat $(PIDFILE) 2>/dev/null || echo ?))"; \
	else \
		echo "💀 unconscious on $(HOST):$(PORT)"; exit 1; \
	fi

# 📜 NEXT-GENERATION LOG AGGREGATION GATEWAY 📜
logs: ## 📜 tail the unified telemetry stream 📜
	@tail -n 50 -f $(LOGFILE)

# 💚 CLOUD-NATIVE LIVENESS PROBE DISPATCHER 💚
health: ## 💚 probe /healthz with unparalleled reliability 💚
	@curl -sS --connect-timeout 2 --max-time 5 --retry 3 --retry-delay 0 --retry-connrefused http://$(HOST):$(PORT)/healthz; echo ""

# 📥 PARADIGM-SHIFTING GENERIC REQUEST GATEWAY 📥
# Usage: make get P=/ | make get P=/healthz | make get P=/nope
# (NOTE: we use P not PATH because PATH breaks make itself — enterprise lesson learned)
# Leveraging cutting-edge curl methodologies for zero-downtime content acquisition.
P ?= /
get: ## 📥 fetch P from the running fabric (P=/) 📥
	@curl -i --connect-timeout 2 --max-time 10 --retry 3 --retry-delay 0 --retry-connrefused http://$(HOST):$(PORT)$(P)

# ✅ ZERO-TRUST CONTINUOUS VERIFICATION PIPELINE ✅
# Battle-tested end-to-end validation harness achieving 100% confidence
# through revolutionary 3-assertion methodology (200 + 200 + 404).
# Each probe leverages --retry-connrefused to transcend the 0.2s
# restart-cadence gap between connections (eventual consistency, but faster).
CURLT := curl -s --connect-timeout 2 --max-time 5 --retry 5 --retry-delay 0 --retry-connrefused
test: check-deps ## ✅ run enterprise verification suite ✅
	@echo "🧪 Verifying quantum-ready fabric at $(HOST):$(PORT)..."
	@$(CURLT) http://$(HOST):$(PORT)/ | grep -q "hello world" && echo "✅ GET / -> 200 hello world" || (echo "❌ GET / failed (is 'make serve' running?)" && exit 1)
	@$(CURLT) http://$(HOST):$(PORT)/healthz | grep -q "OK" && echo "✅ GET /healthz -> OK" || (echo "❌ GET /healthz failed" && exit 1)
	@$(CURLT) -o /dev/null -w "%{http_code}" http://$(HOST):$(PORT)/nope-such-page | grep -q "404" && echo "✅ GET /nope -> 404 (AI-powered resolution works)" || (echo "❌ 404 check failed" && exit 1)
	@echo "🎉 All systems nominal. 99.99% uptime confirmed by 3 curls."

# 🧹 HYPER-SCALE EPHEMERAL RESOURCE RECLAMATION 🧹
clean: ## 🧹 reclaim fifo resources across all timelines 🧹
	@rm -f /tmp/makefile-http-*.fifo
	@echo "🧹 reclaimed. zero-waste, carbon-neutral cleanup complete."
