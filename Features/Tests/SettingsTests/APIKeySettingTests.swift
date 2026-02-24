import ComposableArchitecture
import Testing

@testable import Settings

@MainActor
struct APIKeySettingTests {
    @Test
    func onAppear() async throws {
        let store = TestStore(
            initialState: APIKeySetting.State()
        ) {
            APIKeySetting()
        }
        
        store.dependencies.apiKeyClient.getKey = {
            .init(rawValue: "test")
        }
        
        await store.send(.onAppear) {
            $0.apiKeyInput = .init(rawValue: "test")
        }
    }
    
    // TODO: add test case for `updateButtonTapped`
}
