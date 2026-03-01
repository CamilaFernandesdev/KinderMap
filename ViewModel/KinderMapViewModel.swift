import Foundation

final class KinderMapViewModel: ObservableObject {
    enum Step {
        case welcome
        case childForm
        case questionnaire
        case dashboard
    }

    @Published var step: Step = .welcome
    @Published var child = ChildProfile()
    @Published var questionsByDomain: [DevelopmentDomain: [DomainQuestion]] = [:]
    @Published var answers: [String: Bool] = [:]
    @Published var scores: [DomainScore] = []

    private let jsonLoader = JSONLoaderService()

    func goToNextStep() {
        switch step {
        case .welcome:
            step = .childForm
        case .childForm:
            loadQuestions()
            step = .questionnaire
        case .questionnaire:
            calculateScores()
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
        questionsByDomain = [:]
    }

    private func loadQuestions() {
        let stage = stageForCurrentAge()
        let filtered = jsonLoader.loadQuestions().filter { $0.stage == stage }

        questionsByDomain = Dictionary(grouping: filtered, by: \.domain)
            .mapValues { questions in
                questions.map { DomainQuestion(id: $0.id, domain: $0.domain, text: $0.text) }
            }
    }

    private func calculateScores() {
        let domainValues = DevelopmentDomain.allCases.map { domain -> DomainScore in
            let questions = questionsByDomain[domain] ?? []
            let positives = questions.filter { answers[$0.id] == true }.count
            let total = max(questions.count, 1)
            let normalizedScore = Double(positives) / Double(total)

            let level: String
            let guidance: String

            switch normalizedScore {
            case 0.75...:
                level = "Dentro do esperado"
                guidance = "Siga observando com atividades lúdicas e rotina estável."
            case 0.45..<0.75:
                level = "Em atenção"
                guidance = "Reforce estímulos diários e acompanhe a evolução nas próximas semanas."
            default:
                level = "Precisa de estímulo"
                guidance = "Considere suporte profissional para orientar intervenções específicas."
            }

            return DomainScore(
                domain: domain,
                score: normalizedScore,
                level: level,
                guidance: guidance
            )
        }

        scores = domainValues.sorted { $0.domain.rawValue < $1.domain.rawValue }
    }

    private func stageForCurrentAge() -> DevelopmentStage {
        let years = Calendar.current.dateComponents([.year], from: child.birthDate, to: Date()).year ?? 0

        switch years {
        case ..<2:
            return .sensorimotor
        case 2..<7:
            return .preOperational
        case 7..<12:
            return .concreteOperational
        default:
            return .formalOperational
        }
    }
}
