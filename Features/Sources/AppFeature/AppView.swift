import AstronomyPicture
import ComposableArchitecture
import Models
import Settings
import SwiftUI

public struct AppView: View {
    var store: StoreOf<AppReducer>

    @Shared(.appStorage("colorScheme")) var userColorScheme = UserColorScheme.system

    public init(store: StoreOf<AppReducer>) {
        self.store = store
    }

    public var body: some View {
        TabView {
            NavigationStack {
                TodayView(store: store.scope(state: \.today, action: \.today))
            }
            .tabItem {
                VStack {
                    Image(systemName: "moon.stars")
                    Text("Pictures")
                }
            }

            SettingsView(store: store.scope(state: \.settings, action: \.settings))
                .tabItem {
                    VStack {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
                }
        }
        .preferredColorScheme(userColorScheme.colorScheme)
    }
}
