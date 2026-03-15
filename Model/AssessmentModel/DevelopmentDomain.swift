import Foundation

enum DevelopmentDomain: String, Decodable, CaseIterable, Identifiable {
    case cognitive
    case language
    case motor
    case social

    var id: Self { self }
}