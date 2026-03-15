protocol ScoreCalculating {
    func calculateScores(answers: [QuestionAnswer]) -> [DevelopmentDomain: Int]
}