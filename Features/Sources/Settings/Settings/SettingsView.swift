import APIClient
import ComposableArchitecture
import SwiftUI

public struct SettingsView: View {
    @Bindable var store: StoreOf<Settings>

    public init(store: StoreOf<Settings>) {
        self.store = store
    }

    public var body: some View {
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            List {
                Section {
                    NavigationLink(
                        state: Settings.Path.State.apiKeySetting(
                            APIKeySetting.State()
                        )
                    ) {
                        HStack {
                            RoundedRectangle(cornerRadius: 8)
                                .frame(width: 30, height: 30)
                                .foregroundColor(.yellow)
                                .overlay {
                                    Image(systemName: "key.fill")
                                        .foregroundColor(.white)
                                }
                                .padding(.trailing, 8)

                            Text("API Key")

                            Spacer()

                            Text(APIClient.apiKey?.rawValue.masked ?? "None")
                                .foregroundStyle(Color.secondary)
                        }
                    }
                }

                Section {
                    NavigationLink {
                        LanguageView()
                    } label: {
                        HStack {
                            RoundedRectangle(cornerRadius: 8)
                                .frame(width: 30, height: 30)
                                .foregroundColor(.green)
                                .overlay {
                                    Image(systemName: "globe")
                                        .foregroundColor(.white)
                                }
                                .padding(.trailing, 8)

                            Text("Language")
                        }
                    }

                    NavigationLink {
                        Text("Appearance")
                    } label: {
                        HStack {
                            RoundedRectangle(cornerRadius: 8)
                                .frame(width: 30, height: 30)
                                .foregroundColor(.cyan)
                                .overlay {
                                    Image(systemName: "circle.lefthalf.filled")
                                        .foregroundColor(.white)
                                }
                                .padding(.trailing, 8)

                            Text("Appearance")
                        }
                    }
                }
            }
            .navigationTitle("Settings")
        } destination: { store in
            switch store.case {
            case let .apiKeySetting(store):
                APIKeySettingView(store: store)
            }
        }
    }
}

#Preview {
    NavigationView {
        SettingsView(
            store: .init(
                initialState: Settings.State()
            ) {
                EmptyReducer()
            }
        )
    }
}
