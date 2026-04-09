import Core
import JavaScriptKit

#if os(Wasm32)
let document = JSObject.global.document
if var body = document.body.object {
    body.innerHTML = JSValue.string("<h1>ECME WASM Loaded Successfully</h1>")
}
print("🕸️ ECME WASM Initialized (WASM Target)")
#else
print("🕸️ ECME WASM Initialized (Native Stub)")
#endif

let _ = DeterministicAuditor()
print("✅ WASM Auditor ready.")
