import Foundation

/// Protocol for LLM interaction, allowing for mocked responses in CI/Testing.
public protocol LLMProvider {
    /// Sends a prompt to the LLM and returns the raw string response.
    func complete(prompt: String) async throws -> String
}

/// A Mock LLM Provider that returns pre-defined responses for testing.
public struct MockLLMProvider: LLMProvider {
    public let mockResponse: String

    public init(mockResponse: String = "{}") {
        self.mockResponse = mockResponse
    }

    public func complete(prompt: String) async throws -> String {
        return mockResponse
    }
}
