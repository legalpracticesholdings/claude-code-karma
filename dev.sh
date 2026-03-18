#!/usr/bin/env bash
#
# dev.sh — Start both API and Frontend dev servers
#
# Usage:
#   ./dev.sh          # Start both servers
#   ./dev.sh api      # Start API only
#   ./dev.sh frontend # Start frontend only
#   ./dev.sh stop     # Stop all running servers
#

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
API_DIR="$ROOT_DIR/api"
FRONTEND_DIR="$ROOT_DIR/frontend"

# PID file locations
PID_DIR="$ROOT_DIR/.dev-pids"
API_PID_FILE="$PID_DIR/api.pid"
FRONTEND_PID_FILE="$PID_DIR/frontend.pid"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color
BOLD='\033[1m'

log_info()    { echo -e "${GREEN}[INFO]${NC}  $*"; }
log_warn()    { echo -e "${YELLOW}[WARN]${NC}  $*"; }
log_error()   { echo -e "${RED}[ERROR]${NC} $*"; }
log_section() { echo -e "\n${BOLD}${CYAN}━━━ $* ━━━${NC}\n"; }

# ── Cleanup on exit ──────────────────────────────────────────────
cleanup() {
    log_section "Shutting down dev servers"

    if [[ -f "$API_PID_FILE" ]]; then
        local api_pid
        api_pid=$(cat "$API_PID_FILE")
        if kill -0 "$api_pid" 2>/dev/null; then
            log_info "Stopping API server (PID $api_pid)..."
            kill "$api_pid" 2>/dev/null || true
            wait "$api_pid" 2>/dev/null || true
        fi
        rm -f "$API_PID_FILE"
    fi

    if [[ -f "$FRONTEND_PID_FILE" ]]; then
        local fe_pid
        fe_pid=$(cat "$FRONTEND_PID_FILE")
        if kill -0 "$fe_pid" 2>/dev/null; then
            log_info "Stopping Frontend server (PID $fe_pid)..."
            kill "$fe_pid" 2>/dev/null || true
            wait "$fe_pid" 2>/dev/null || true
        fi
        rm -f "$FRONTEND_PID_FILE"
    fi

    rm -rf "$PID_DIR"
    log_info "All servers stopped. Bye!"
}

trap cleanup EXIT INT TERM

# ── Stop command ─────────────────────────────────────────────────
stop_servers() {
    if [[ ! -d "$PID_DIR" ]]; then
        log_warn "No running servers found."
        exit 0
    fi

    for pid_file in "$PID_DIR"/*.pid; do
        [[ -f "$pid_file" ]] || continue
        local pid name
        pid=$(cat "$pid_file")
        name=$(basename "$pid_file" .pid)
        if kill -0 "$pid" 2>/dev/null; then
            log_info "Stopping $name (PID $pid)..."
            kill "$pid" 2>/dev/null || true
        else
            log_warn "$name (PID $pid) already stopped."
        fi
        rm -f "$pid_file"
    done

    rm -rf "$PID_DIR"
    log_info "Done."
    # Exit without triggering the trap cleanup (already cleaned up)
    trap - EXIT
    exit 0
}

# ── Start API server ────────────────────────────────────────────
start_api() {
    log_section "Starting API Server"

    if [[ ! -d "$API_DIR" ]]; then
        log_error "API directory not found: $API_DIR"
        return 1
    fi

    log_info "Directory: ${BLUE}$API_DIR${NC}"
    log_info "URL:       ${BLUE}http://localhost:9005${NC}"
    log_info "Docs:      ${BLUE}http://localhost:9005/docs${NC}"

    cd "$API_DIR"
    uvicorn main:app --reload --port 9005 2>&1 | while IFS= read -r line; do
        echo -e "${GREEN}[API]${NC} $line"
    done &
    local pid=$!
    echo "$pid" > "$API_PID_FILE"

    log_info "API server started (PID $pid)"
}

# ── Start Frontend server ───────────────────────────────────────
start_frontend() {
    log_section "Starting Frontend Server"

    if [[ ! -d "$FRONTEND_DIR" ]]; then
        log_error "Frontend directory not found: $FRONTEND_DIR"
        return 1
    fi

    log_info "Directory: ${BLUE}$FRONTEND_DIR${NC}"
    log_info "URL:       ${BLUE}http://localhost:5199${NC}"

    cd "$FRONTEND_DIR"
    npm run dev 2>&1 | while IFS= read -r line; do
        echo -e "${YELLOW}[FE]${NC}  $line"
    done &
    local pid=$!
    echo "$pid" > "$FRONTEND_PID_FILE"

    log_info "Frontend server started (PID $pid)"
}

# ── Main ────────────────────────────────────────────────────────
main() {
    local mode="${1:-all}"

    mkdir -p "$PID_DIR"

    echo -e "${BOLD}${CYAN}"
    echo "  ╔══════════════════════════════════════╗"
    echo "  ║     Claude Code Karma — Dev Mode     ║"
    echo "  ╚══════════════════════════════════════╝"
    echo -e "${NC}"

    case "$mode" in
        api)
            start_api
            ;;
        frontend|fe)
            start_frontend
            ;;
        stop)
            stop_servers
            ;;
        all|"")
            start_api
            start_frontend
            echo ""
            log_section "All servers running"
            log_info "API:      ${BLUE}http://localhost:9005${NC}"
            log_info "Frontend: ${BLUE}http://localhost:5199${NC}"
            log_info "API Docs: ${BLUE}http://localhost:9005/docs${NC}"
            echo ""
            log_info "Press ${BOLD}Ctrl+C${NC} to stop all servers."
            ;;
        *)
            echo "Usage: $0 [api|frontend|stop]"
            echo ""
            echo "  (no args)  Start both API and Frontend"
            echo "  api        Start API server only (port 9005)"
            echo "  frontend   Start Frontend server only (port 5199)"
            echo "  stop       Stop all running dev servers"
            exit 1
            ;;
    esac

    # Keep the script running so we can catch Ctrl+C
    wait
}

main "$@"
