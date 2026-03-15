enum DevelopmentStage: String, Decodable, CaseIterable {
    case sensorimotor      // 0–2 anos
    case preOperational    // 2–7 anos
    case concreteOperational  // 7–11 anos
    case formalOperational    // 11+ anos

    /// Estágio indicado para a idade em anos (referência Piaget).
    static func stage(forAgeYears age: Int) -> DevelopmentStage {
        switch age {
        case ..<2: return .sensorimotor
        case 2..<7: return .preOperational
        case 7..<11: return .concreteOperational
        default: return .formalOperational
        }
    }
}
