
final class InterpretationService: InterpretationCalculating {

    func interpret(domainScores: [DevelopmentDomain: Int]) -> [DomainResult] {

        domainScores.map { entry in
            let score = entry.value
            let level: DevelopmentLevel

            switch score {
            case 12...14:
                level = .adequado
            case 8...11:
                level = .atencao
            default:
                level = .estimulacao
            }

            return DomainResult(domain: entry.key, score: score, level: level)
        }
    }
}