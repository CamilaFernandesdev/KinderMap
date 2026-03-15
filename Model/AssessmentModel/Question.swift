import Foundation

struct Question: Identifiable, Decodable {
    let id: String
    let text: String
    let domain: DevelopmentDomain
    let stage: DevelopmentStage
}