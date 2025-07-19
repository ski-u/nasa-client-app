import APIClient
import ComposableArchitecture
import LicenseList
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
                        Label {
                            HStack {
                                Text("API Key")
                                
                                Spacer()
                                
                                Text(store.apiKey.masked ?? "None")
                                    .foregroundStyle(Color.secondary)
                            }
                        } icon: {
                            Image(systemName: "key.fill")
                                .foregroundStyle(Color.yellow)
                        }
                    }
                    
                    NavigationLink {
                        AppearanceView()
                    } label: {
                        Label {
                            Text("Appearance")
                        } icon: {
                            Image(systemName: "circle.lefthalf.filled")
                                .foregroundStyle(Color.cyan)
                        }
                    }
                }
                
                Section {
                    NavigationLink {
                        LicenseListView()
                            .licenseViewStyle(.withRepositoryAnchorLink)
                            .navigationTitle(.init("Acknowledgement"))
                    } label: {
                        Label {
                            Text("Acknowledgement")
                        } icon: {
                            Image(systemName: "wrench.and.screwdriver.fill")
                                .foregroundColor(.gray)
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
        .onAppear {
            store.send(.onAppear)
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
