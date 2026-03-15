final class ScoringService: ScoreCalculating {

    func calculateScores(answers: [QuestionAnswer]) -> [DevelopmentDomain: Int] {
        var scores: [DevelopmentDomain: Int] = [:]

        for answer in answers {
            scores[answer.domain, default: 0] += answer.value.rawValue
        }

        return scores
    }
}