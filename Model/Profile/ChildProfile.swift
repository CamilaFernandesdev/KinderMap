import Foundation

struct ChildProfile {
    var name: String = ""
    var gender: Gender = .unspecified
    var birthDate: Date = Calendar.current.date(byAdding: .year, value: -4, to: Date()) ?? Date()
}

