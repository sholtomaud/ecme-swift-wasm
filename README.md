# ECME-Swift-WASM

Dual-target system for the **ECME** protocol, built in Swift for both Native CLI and WebAssembly (WASM).

## 🚀 Features
- **Deterministic Auditor**: Pure Swift logic for Pass 7 of the ECME protocol.
- **SQLite Persistence**: Native storage for the 7-pass history.
- **WASM Bridge**: Integration with the browser via JavaScriptKit.

## 🏗 Stack
- **Swift 6.0+**
- **SwiftWasm / Carton** (for WASM target)
- **SQLite.swift** (for native persistence)

## 🛠 Usage

### Initialization
```bash
make init
```

### Build Targets
- **Native macOS**: `make build-mac`
- **WebAssembly**: `make build-wasm`
- **Test Suite**: `make test`

## 🏃 Running the Program

### Native CLI
You can run the built binary directly:
```bash
./bin/ecme
```
Or use Swift Package Manager to run it in-place:
```bash
swift run ecme
```

### WebAssembly (WASM)
To launch a development server and preview the WASM implementation in your browser:
```bash
carton dev
```

## 📂 Project Structure
- `Sources/Core`: Shared logic and models.
- `Sources/ECME`: Native CLI implementation.
- `Sources/ECMEWasm`: WASM bridge implementation.
- `schema/`: JSON schemas for Epistemic Signals.
- `scripts/`: Automation and synchronization scripts.
