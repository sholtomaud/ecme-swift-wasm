import Foundation
import Core

print("🚀 ECME CLI Initialized")

// Dependency Injection for the LLM Provider
let provider: LLMProvider
if ProcessInfo.processInfo.environment["LLM_MODE"] == "mock" {
    print("🧪 Running in MOCK mode")
    provider = MockLLMProvider(mockResponse: "{\"status\": \"mocked\"}")
} else {
    provider = LlamaLocalProvider(port: 8080)
}

let _ = DeterministicAuditor()
print("✅ Auditor ready.")

// Simple test call (optional, for verification)
if CommandLine.arguments.contains("--test-connectivity") {
    // Top-level async is supported in main.swift
    do {
        print("📡 Testing connectivity to LLM...")
        let response = try await provider.complete(prompt: "Hello")
        print("📩 Received: \(response)")
    } catch {
        print("❌ LLM Error: \(error)")
    }
}
