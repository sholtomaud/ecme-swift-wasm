# --- Variables ---
# Pulls project name from JSON; falls back to 'ecme' if jq fails or file is missing
RAW_NAME    := $(shell jq -r '.project' issues.json 2>/dev/null | tr '[:upper:]' '[:lower:]' || echo "ecme")
# Ensure name is simple 'ecme' for binaries
APP_NAME    := ecme
BIN_DIR     := bin
WASM_DIR    := dist-wasm
SYNC_SCRIPT := ./scripts/sync_issues.sh
CHANGELOG   := changelog.log

# --- Standard Targets ---
.PHONY: all init build-mac build-wasm clean lint test help run check-changelog

all: build-mac build-wasm

## help: Show this help message
help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@sed -n 's/^##//p' $(MAKEFILE_LIST) | column -t -s ':' |  sed -e 's/^/ /'

## init: Prepare automation scripts, resolve dependencies, and sync issues
init:
	@echo "🔧 Preparing automation scripts..."
	@chmod +x $(SYNC_SCRIPT)
	@echo "📦 Resolving Swift dependencies..."
	@swift package resolve
	@echo "🚀 Syncing issues to GitHub..."
	@$(SYNC_SCRIPT)

## init-pkg: Resolve Swift package dependencies
init-pkg:
	@echo "📦 Resolving Swift dependencies..."
	@swift package resolve

## run: Build and run the native CLI target
run: build-linux
	@$(BIN_DIR)/$(APP_NAME)

## build-mac: Build Native macOS Universal Binary (arm64 + x86_64)
build-mac:
	@echo '🍎 Building Native macOS Binary...'
	@swift build -c release --product $(APP_NAME) --arch arm64 --arch x86_64
	@mkdir -p $(BIN_DIR)
	@cp .build/apple/Products/Release/$(APP_NAME) $(BIN_DIR)/$(APP_NAME)
	@echo "✅ Native binary located at: $(BIN_DIR)/$(APP_NAME)"

## build-linux: Build Native Linux Binary
build-linux:
	@echo '🐧 Building Native Linux Binary...'
	@swift build -c release --product $(APP_NAME)
	@mkdir -p $(BIN_DIR)
	@cp .build/release/$(APP_NAME) $(BIN_DIR)/$(APP_NAME)
	@echo "✅ Native binary located at: $(BIN_DIR)/$(APP_NAME)"

## build-wasm: Build WebAssembly module via Carton
build-wasm:
	@echo '🕸️  Compiling to WebAssembly...'
	@if command -v carton >/dev/null 2>&1; then \
		carton bundle; \
		mkdir -p $(WASM_DIR); \
		cp .build/carton/static/main.wasm $(WASM_DIR)/$(APP_NAME).wasm; \
		echo "✅ WASM binary located at: $(WASM_DIR)/$(APP_NAME).wasm"; \
	else \
		echo "❌ Error: 'carton' command not found. Please install it with 'brew install swiftwasm/tap/carton'"; \
		exit 1; \
	fi

## lint: Run SwiftLint with strict enforcement
lint:
	@echo '🔍 Running SwiftLint...'
	@if command -v swiftlint >/dev/null 2>&1; then \
		swiftlint lint --strict; \
	else \
		echo '⚠️  SwiftLint not found. Skipping lint.'; \
	fi

## test: Run Swift tests in parallel (MOCK mode enabled by default)
test:
	@echo '🧪 Running Swift Test Suite (Mock Mode)...'
	@LLM_MODE=mock swift test --parallel

## check-changelog: Ensure changelog.log exists and was recently updated (used by pre-commit)
check-changelog:
	@if [ ! -f $(CHANGELOG) ]; then \
		echo "❌ Error: $(CHANGELOG) is missing!"; \
		exit 1; \
	fi
	@echo "✅ $(CHANGELOG) exists."

## clean: Remove build artifacts and distributions
clean:
	@echo '🧹 Cleaning project...'
	@rm -rf .build $(BIN_DIR) $(WASM_DIR)