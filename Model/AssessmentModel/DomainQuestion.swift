import Foundation

struct DomainQuestion: Identifiable {
    let id: UUID
    let domain: DevelopmentDomain
    let text: String
    /// Used when building QuestionAnswer for scoring (from JSON Question.id).
    var questionId: String?

    init(domain: DevelopmentDomain, text: String, id: UUID = UUID(), questionId: String? = nil) {
        self.id = id
        self.domain = domain
        self.text = text
        self.questionId = questionId
    }
}

