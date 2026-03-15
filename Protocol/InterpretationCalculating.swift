protocol InterpretationCalculating {
    func interpret(domainScores: [DevelopmentDomain: Int]) -> [DomainResult]
}

