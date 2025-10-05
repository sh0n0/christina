import SwiftUI

struct ErrorView: View {
    let message: String
    let retryAction: () async -> Void

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "exclamationmark.triangle")
                .imageScale(.large)
            Text(message)
                .multilineTextAlignment(.center)
            Button("Retry") {
                Task { await retryAction() }
            }
        }
        .padding()
    }
}

#Preview {
    ErrorView(message: "Something went wrong.\nPlease try again.") {
        try? await Task.sleep(nanoseconds: 300_000_000)
    }
}
