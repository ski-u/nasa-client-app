import APIClientLive
import AppFeature
import SwiftUI

@main
struct NASAClientApp: App {
    var body: some Scene {
        WindowGroup {
            AppView(
                store: .init(initialState: .init()) {
                    AppReducer().transformDependency(\.self) {
                        // Use `mockValue` to return mock response due to the unavailabillity of NASA APIs. (as of 2025/10/16)
                        // See https://github.com/nasa/apod-api/issues/139 for more detail.
                        $0.apiClient = .mockValue
                    }
                }
            )
        }
    }
}
