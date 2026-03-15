import SwiftUI

struct QuestionnaireView: View {
    @ObservedObject var viewModel: AssessmentViewModel

    var body: some View {
        VStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Observações do dia a dia")
                    .font(.system(.title2, design: .rounded, weight: .semibold))

                Text("Marque o que costuma acontecer com mais frequência com a sua criança.")
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            ScrollView {
                VStack(spacing: 18) {
                    ForEach(DevelopmentDomain.allCases) { domain in
                        if let questions = viewModel.questionsByDomain[domain] {
                            DomainSectionView(domain: domain,
                                              questions: questions,
                                              answers: $viewModel.answers)
                        }
                    }
                }
                .padding(.vertical, 4)
            }

            PrimaryButton(title: "Ver análise") {
                withAnimation(.spring(response: 0.45, dampingFraction: 0.9)) {
                    viewModel.goToNextStep()
                }
            }
            .padding(.top, 4)
        }
    }
}

struct DomainSectionView: View {
    let domain: DevelopmentDomain
    let questions: [DomainQuestion]
    @Binding var answers: [UUID: Bool]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(domain.rawValue)
                    .font(.system(.headline, design: .rounded))
                Spacer()
                Capsule()
                    .fill(domain.color.opacity(0.2))
                    .frame(width: 56, height: 8)
            }

            ForEach(questions) { question in
                Toggle(isOn: Binding(
                    get: { answers[question.id] ?? false },
                    set: { answers[question.id] = $0 }
                )) {
                    Text(question.text)
                        .font(.system(.subheadline, design: .rounded))
                        .foregroundStyle(.primary)
                }
                .toggleStyle(SwitchToggleStyle(tint: domain.color))
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.appSecondaryBackground.opacity(0.95))
        )
    }
}

