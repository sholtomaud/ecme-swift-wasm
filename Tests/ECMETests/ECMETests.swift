import XCTest
@testable import Core

final class ECMETests: XCTestCase {
    func testAuditorInitialization() throws {
        let auditor = DeterministicAuditor()
        XCTAssertNotNil(auditor)
    }

    func testEpistemicSignalEncoding() throws {
        // Minimal test to ensure models are working
        let metrics = EpistemicSignal.SignalMetrics(semanticErrorRate: 0.1, cognitiveBandwidth: 0.8)
        let signal = EpistemicSignal(hash: "abc", title: "Test", rawText: "Source", propositions: [], relations: [], metrics: metrics)
        let data = try JSONEncoder().encode(signal)
        XCTAssertFalse(data.isEmpty)
    }
}
