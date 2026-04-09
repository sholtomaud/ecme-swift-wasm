import Foundation

/// The Deterministic Auditor (Pass 7)
/// Acts as the Cybernetic Governor to ensure signal integrity.
public struct DeterministicAuditor {
    
    public init() {}

    /// Audits an Epistemic Signal against the source text.
    public func audit(signal: EpistemicSignal, sourceText: String) -> [String] {
        var issues: [String] = []
        
        // 1. Verbatim Check: Ensure justifications exist in source
        for relation in signal.relations {
            if !sourceText.contains(relation.justification) {
                issues.append("Hallucination: Relation \(relation.from) -> \(relation.to) cites non-existent quote.")
            }
        }
        
        // 2. Grounding Check: Ensure propositions contain anchors
        for prop in signal.propositions {
            let hasAnchor = prop.anchors.contains { anchor in
                prop.text.lowercased().contains(anchor.lowercased())
            }
            if !hasAnchor {
                issues.append("Ungrounded: Proposition \(prop.id) contains no verified anchors.")
            }
        }
        
        return issues
    }
}