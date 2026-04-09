# AGENTS.md: Swift-WASM ECME Instructions

## 1. Context
You are building the **ECME** in Swift. The goal is a dual-target system: Native CLI and WASM for the web.

## 2. The Stack
- **Language:** Swift 6.0+
- **Build System:** Swift Package Manager (SPM)
- **WASM Toolchain:** SwiftWasm / Carton
- **Persistence:** SQLite3 (C-interop)

## 3. Workflow
- **Development Approach:** **Test-Driven Development (TDD)** is mandatory. Write tests before implementation.
- **Build Native:** `make build-mac`
- **Build WASM:** `make build-wasm`
- **Test:** `make test`

## 4. Constraints
- **Changelog:** A `changelog.log` file must be maintained and updated as part of the pre-commit process.
- **Serialization:** Use `Codable` for all Epistemic Signal structures.
- **Logic Sharing:** Ensure all "Deterministic Auditor" logic is in the `Core` library so it can be shared between CLI and WASM.