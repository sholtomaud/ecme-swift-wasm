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

### Build Native CLI
```bash
make build-mac
```

### Build WebAssembly
```bash
make build-wasm
```

### Run Tests
```bash
make test
```

## 📂 Project Structure
- `Sources/Core`: Shared logic and models.
- `Sources/ECME`: Native CLI implementation.
- `Sources/ECMEWasm`: WASM bridge implementation.
- `schema/`: JSON schemas for Epistemic Signals.
- `scripts/`: Automation and synchronization scripts.
