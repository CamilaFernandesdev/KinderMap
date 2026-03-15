import Foundation

struct DomainScore: Identifiable {
    let id = UUID()
    let domain: DevelopmentDomain
    let score: Double   // 0...1
    let level: String
    let guidance: String
}
