import Foundation

public enum RelationType: String, Codable, CaseIterable {
    case assoc, disc, dep, gap
}

public struct Proposition: Codable, Identifiable {
    public let id: Int
    public let text: String
    public let anchors: [String]
    public let sourceQuote: String
    public let index: Int

    public init(id: Int, text: String, anchors: [String], sourceQuote: String, index: Int) {
        self.id = id
        self.text = text
        self.anchors = anchors
        self.sourceQuote = sourceQuote
        self.index = index
    }
}

public struct Relation: Codable {
    public let from: Int
    public let to: Int
    public let type: RelationType
    public let justification: String
    public var isHallucination: Bool?

    public init(from: Int, to: Int, type: RelationType, justification: String, isHallucination: Bool? = nil) {
        self.from = from
        self.to = to
        self.type = type
        self.justification = justification
        self.isHallucination = isHallucination
    }
}

public struct EpistemicSignal: Codable {
    public let hash: String
    public let title: String
    public let rawText: String
    public let propositions: [Proposition]
    public let relations: [Relation]
    public let metrics: SignalMetrics

    public struct SignalMetrics: Codable {
        public let semanticErrorRate: Double
        public let cognitiveBandwidth: Double
    }
}
