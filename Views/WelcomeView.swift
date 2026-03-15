import SwiftUI

struct WelcomeView: View {
    let onStart: () -> Void
    var namespace: Namespace.ID

    var body: some View {
        VStack(spacing: 24) {
            VStack(alignment: .leading, spacing: 12) {
                Text("KinderMap")
                    .font(.system(.largeTitle, design: .rounded, weight: .bold))
                    .matchedGeometryEffect(id: "title", in: namespace)

                Text("Um mapa gentil do desenvolvimento da sua criança.")
                    .font(.system(.body, design: .rounded))
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            ZStack {
                RoundedRectangle(cornerRadius: 32, style: .continuous)
                    .fill(
                        LinearGradient(colors: [
                            Color.blue.opacity(0.2),
                            Color.purple.opacity(0.15)
                        ], startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .shadow(color: Color.black.opacity(0.08), radius: 16, x: 0, y: 8)

                VStack(spacing: 16) {
                    HStack(spacing: 12) {
                        Circle()
                            .fill(Color.blue.opacity(0.8))
                            .frame(width: 16, height: 16)
                        Circle()
                            .fill(Color.orange.opacity(0.8))
                            .frame(width: 12, height: 12)
                        Circle()
                            .strokeBorder(Color.white.opacity(0.9), lineWidth: 2)
                            .background(Circle().fill(Color.pink.opacity(0.8)))
                            .frame(width: 20, height: 20)
                        Spacer()
                    }

                    Text("Visualize, em poucos minutos, como a sua criança está se desenvolvendo em diferentes domínios.")
                        .font(.system(.callout, design: .rounded))
                        .foregroundStyle(.primary)
                        .multilineTextAlignment(.leading)

                    Text("Este não é um diagnóstico, mas um ponto de partida para observar, acolher e apoiar.")
                        .font(.system(.caption, design: .rounded))
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.leading)
                }
                .padding(24)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 220)

            Spacer()

            PrimaryButton(title: "Começar") {
                onStart()
            }
            .matchedGeometryEffect(id: "primaryButton", in: namespace)
        }
    }
}

