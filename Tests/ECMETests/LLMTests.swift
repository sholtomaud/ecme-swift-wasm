import XCTest
import Core

final class LLMTests: XCTestCase {
    
    /// Test the MockLLMProvider in a simulated "CI" environment.
    func testMockLLMProvider() async throws {
        let mockJSON = "{\"status\": \"ok\"}"
        let provider = MockLLMProvider(mockResponse: mockJSON)
        
        let response = try await provider.complete(prompt: "Test prompt")
        XCTAssertEqual(response, mockJSON)
    }
    
    /// Integration test for the Real Llama Server.
    /// Skips automatically if the server is not reachable on port 8080.
    func testLlamaLocalConnectivity() async throws {
        let provider = LlamaLocalProvider(port: 8080)
        
        // Check if server is up
        let serverIsUp: Bool
        do {
            let (_, response) = try await URLSession.shared.data(from: provider.baseURL)
            serverIsUp = (response as? HTTPURLResponse)?.statusCode != nil
        } catch {
            serverIsUp = false
        }
        
        try XCTSkipIf(!serverIsUp, "Local Llama server not found on port 8080. Skipping integration test.")
        
        // If up, try a simple completion
        let response = try await provider.complete(prompt: "Say 'Hello'")
        XCTAssertFalse(response.isEmpty)
    }
}
