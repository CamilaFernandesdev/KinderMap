import Combine
import Foundation
import SwiftUI

enum AssessmentStep: Equatable {
    case welcome
    case childForm
    case questionnaire
    case dashboard
}

final class AssessmentViewModel: ObservableObject {
    @Published var step: AssessmentStep = .welcome
    @Published var child = ChildProfile()
    @Published var answers: [UUID: Bool] = [:]
    @Published var scores: [DomainScore] = []

    var childAgeInYears: Int {
        Calendar.current.dateComponents([.year], from: child.birthDate, to: Date()).year ?? 0
    }

    var childStage: DevelopmentStage {
        DevelopmentStage.stage(forAgeYears: childAgeInYears)
    }

    var questionsByDomain: [DevelopmentDomain: [DomainQuestion]] {
        Dictionary(grouping: domainQuestions, by: \.domain)
    }

    private var domainQuestions: [DomainQuestion] {
        allQuestions.filter { $0.stage == childStage }.map { q in
            DomainQuestion(
                domain: q.domain,
                text: q.text,
                id: UUID(uuidString: q.id) ?? UUID(),
                questionId: q.id
            )
        }
    }

    private var allQuestions: [Question] = []
    private let jsonLoader = JSONLoaderService()
    private let scoringService: ScoreCalculating = ScoringService()
    private let interpretationService: InterpretationCalculating = InterpretationService()

    var childNameBinding: Binding<String> {
        Binding(get: { self.child.name }, set: { self.child.name = $0 })
    }
    var childGenderBinding: Binding<Gender> {
        Binding(get: { self.child.gender }, set: { self.child.gender = $0 })
    }
    var childBirthDateBinding: Binding<Date> {
        Binding(get: { self.child.birthDate }, set: { self.child.birthDate = $0 })
    }

    init() {
        loadQuestions()
    }

    func goToNextStep() {
        switch step {
        case .welcome:
            step = .childForm
        case .childForm:
            step = .questionnaire
        case .questionnaire:
            finalizeQuestionnaire()
            step = .dashboard
        case .dashboard:
            break
        }
    }

    func resetFlow() {
        step = .welcome
        child = ChildProfile()
        answers = [:]
        scores = []
    }

    private func loadQuestions() {
        allQuestions = jsonLoader.loadQuestions()
    }

    private func finalizeQuestionnaire() {
        let questionAnswers: [QuestionAnswer] = domainQuestions.compactMap { q in
            let value: AnswerOption = (answers[q.id] == true) ? .yes : .no
            guard let qId = q.questionId else { return nil }
            return QuestionAnswer(questionId: qId, domain: q.domain, value: value)
        }
        let domainScores = scoringService.calculateScores(answers: questionAnswers)
        let results = interpretationService.interpret(domainScores: domainScores)
        scores = results.map { result in
            DomainScore(
                domain: result.domain,
                score: Double(result.score) / 14.0,
                level: levelString(result.level),
                guidance: guidanceString(result.level)
            )
        }
    }
}

private func levelString(_ level: DevelopmentLevel) -> String {
    switch level {
    case .adequado: return "Adequado"
    case .atencao: return "Atenção"
    case .estimulacao: return "Estimulação"
    }
}

private func guidanceString(_ level: DevelopmentLevel) -> String {
    switch level {
    case .adequado: return "Manter as interações e brincadeiras atuais."
    case .atencao: return "Vale observar e acompanhar o desenvolvimento."
    case .estimulacao: return "Incentivar atividades que favoreçam esta área."
    }
}
