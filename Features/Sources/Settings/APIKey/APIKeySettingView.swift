import ComposableArchitecture
import SwiftUI

struct APIKeySettingView: View {
    let store: StoreOf<APIKeySetting>
    @ObservedObject private var viewStore: ViewStoreOf<APIKeySetting>
    
    init(store: StoreOf<APIKeySetting>) {
        self.store = store
        viewStore = .init(store, observe: { $0 })
    }
    
    var body: some View {
        List {
            Section(footer: link) {
                TextField(
                    String(localized: "Set your API key", bundle: .module),
                    text: viewStore.binding(
                        get: \.apiKeyInput.rawValue,
                        send: APIKeySetting.Action.setAPIKeyInput
                    )
                )
                .textFieldStyle(.plain)
            }
        }
        .navigationTitle(Text("API key", bundle: .module))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button(action: { viewStore.send(.updateButtonTapped) }) {
                    Text("Save", bundle: .module)
                }
                .disabled(!viewStore.isEdited)
            }
        }
        .onAppear {
            viewStore.send(.onAppear)
        }
    }
    
    private var link: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("You can generate your API key on:", bundle: .module)
            Link(
                "NASA Open APIs",
                destination: URL(string: "https://api.nasa.gov/")!
            )
            .font(.caption)
        }
    }
}

struct APIKeyView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            APIKeySettingView(
                store: .init(
                    initialState: APIKeySetting.State()
                ) {
                    EmptyReducer()
                }
            )
        }
    }
}
