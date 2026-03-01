import SwiftUI

extension DevelopmentDomain {
    var color: Color {
        switch self {
        case .motor: return Color.blue
        case .language: return Color.purple
        case .social: return Color.orange
        case .cognitive: return Color.green
        }
    }
}

