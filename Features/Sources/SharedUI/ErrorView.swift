import SwiftUI

public struct ErrorView: View {
    let error: Text
    let retry: () -> Void
    
    public init(
        error: Text,
        retry: @escaping () -> Void,
    ) {
        self.error = error
        self.retry = retry
    }
    
    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                Label {
                    Text("Error", bundle: .module)
                        .bold()
                } icon: {
                    Image(systemName: "exclamationmark.circle.fill")
                }
                .font(.title2)
                .foregroundStyle(Color.red)
                
                error
                    .multilineTextAlignment(.leading)
                
                Button(action: retry) {
                    Text("Retry", bundle: .module)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundStyle(Color.red.opacity(0.1))
            }
        }
    }
}

#Preview {
    ErrorView(
        error: Text("Something wrong happened"),
        retry: {},
    )
    .padding()
}
