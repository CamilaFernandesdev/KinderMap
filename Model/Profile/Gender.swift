import Foundation

enum Gender: String, CaseIterable, Identifiable {
    case female = "Female"
    case male = "Male"
    case unspecified = "I don't want to inform"

    var id: String { rawValue }
}

