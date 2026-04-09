# AGENTS.md: Swift-WASM ECME Instructions

## 1. Context
You are building the **ECME** in Swift. The goal is a dual-target system: Native CLI and WASM for the web.

## 2. The Stack
- **Language:** Swift 6.0+
- **Build System:** Swift Package Manager (SPM)
- **WASM Toolchain:** SwiftWasm / Carton
- **Persistence:** SQLite3 (C-interop)

## 3. Workflow
- **Build Native:** `make build-mac`
- **Build WASM:** `make build-wasm`
- **Test:** `swift test`

## 4. Constraints
- Use `Codable` for all Epistemic Signal structures.
- Ensure all "Deterministic Auditor" logic is in the `Core` library so it can be shared between CLI and WASM.