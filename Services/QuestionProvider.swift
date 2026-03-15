protocol QuestionProvider {
    func fetchQuestions() throws -> [Question]
}