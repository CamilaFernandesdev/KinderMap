import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = AssessmentViewModel()
    @Namespace private var animationNamespace

    var body: some View {
        ZStack {
            LinearGradient(colors: [
                Color.blue.opacity(0.25),
                Color.appSystemBackground
            ], startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea()

            VStack {
                Spacer(minLength: 0)

                Group {
                    switch viewModel.step {
                    case .welcome:
                        WelcomeView(
                            onStart: {
                                withAnimation(.spring(response: 0.45, dampingFraction: 0.9)) {
                                    viewModel.goToNextStep()
                                }
                            },
                            namespace: animationNamespace
                        )
                    case .childForm:
                        ChildFormView(viewModel: viewModel, namespace: animationNamespace)
                    case .questionnaire:
                        QuestionnaireView(viewModel: viewModel)
                    case .dashboard:
                        DashboardView(viewModel: viewModel, namespace: animationNamespace)
                    }
                }
                .transition(.asymmetric(insertion: .move(edge: .trailing).combined(with: .opacity),
                                        removal: .move(edge: .leading).combined(with: .opacity)))

                Spacer(minLength: 0)
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 16)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
        ContentView()
            .preferredColorScheme(.dark)
    }
}
