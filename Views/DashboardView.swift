import SwiftUI

struct DashboardView: View {
    @ObservedObject var viewModel: AssessmentViewModel
    var namespace: Namespace.ID

    var body: some View {
        VStack(spacing: 18) {
            VStack(alignment: .leading, spacing: 6) {
                Text("Mapa do desenvolvimento")
                    .font(.system(.title2, design: .rounded, weight: .semibold))
                    .matchedGeometryEffect(id: "title", in: namespace)

                let childName = viewModel.child.name
                if !childName.isEmpty {
                    Text(childName)
                        .font(.system(.callout, design: .rounded))
                        .foregroundStyle(.secondary)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            if viewModel.scores.isEmpty {
                Text("Preencha o formulário para ver a análise.")
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
            } else {
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .fill(Color.appSecondaryBackground.opacity(0.95))
                    .overlay(
                        VStack(spacing: 16) {
                            ForEach(viewModel.scores) { item in
                                DashboardRow(score: item)
                            }
                        }
                        .padding(18)
                    )
            }

            Spacer()

            HStack(spacing: 12) {
                SecondaryButton(title: "Recomeçar") {
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.9)) {
                        viewModel.resetFlow()
                    }
                }

                PrimaryButton(title: "Ajustar respostas") {
                    withAnimation(.spring(response: 0.45, dampingFraction: 0.9)) {
                        viewModel.step = .questionnaire
                    }
                }
                .matchedGeometryEffect(id: "primaryButton", in: namespace)
            }
        }
    }
}

struct DashboardRow: View {
    let score: DomainScore

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(score.domain.rawValue)
                    .font(.system(.subheadline, design: .rounded, weight: .semibold))
                Spacer()
                Text(score.level)
                    .font(.system(.caption, design: .rounded, weight: .medium))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(score.domain.color.opacity(0.15))
                    .clipShape(Capsule())
            }

            GeometryReader { proxy in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(Color.appTertiaryFill)
                    Capsule()
                        .fill(score.domain.color.gradient)
                        .frame(width: proxy.size.width * max(0.05, CGFloat(score.score)))
                        .animation(.easeOut(duration: 0.6), value: score.score)
                }
            }
            .frame(height: 10)

            Text(score.guidance)
                .font(.system(.caption, design: .rounded))
                .foregroundStyle(.secondary)
        }
    }
}

