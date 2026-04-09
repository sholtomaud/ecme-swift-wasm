import Foundation

/// Concrete provider that hits a local llama.cpp server on port 8080.
public struct LlamaLocalProvider: LLMProvider {
    public let baseURL: URL
    private let session: URLSession

    public init(port: Int = 8080) {
        self.baseURL = URL(string: "http://localhost:\(port)/v1/chat/completions")!
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 60 // LLMs can be slow
        self.session = URLSession(configuration: config)
    }

    public func complete(prompt: String) async throws -> String {
        var request = URLRequest(url: baseURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // Prepare simple OpenAI-style request for llama.cpp /v1
        let payload: [String: Any] = [
            "messages": [
                ["role": "user", "content": prompt]
            ],
            "temperature": 0.1,
            "max_tokens": 4096,
            "stream": false
        ]

        request.httpBody = try JSONSerialization.data(withJSONObject: payload)

        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw LLMError.unsuccessfulResponse(response: response)
        }

        // We expect an OpenAI-compatible response structure
        let decoded = try JSONDecoder().decode(OAIResponse.self, from: data)
        return decoded.choices.first?.message.content ?? ""
    }
}

// MARK: - Internal Helper Types

internal struct OAIResponse: Codable {
    struct Choice: Codable {
        struct Message: Codable {
            let content: String
        }
        let message: Message
    }
    let choices: [Choice]
}

public enum LLMError: Error {
    case unsuccessfulResponse(response: URLResponse)
    case invalidResponseData
}
