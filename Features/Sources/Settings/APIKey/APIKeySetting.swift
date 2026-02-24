import APIClient
import APIKeyClient
import ComposableArchitecture
import Models

@Reducer
public struct APIKeySetting {
    @ObservableState
    public struct State: Equatable {
        var apiKeyInput: APIKey
        var initialAPIKey: APIKey
        
        var isEdited: Bool {
            apiKeyInput != initialAPIKey
        }
        
        public init(
            apiKeyInput: APIKey = .init(rawValue: "")
        ) {
            self.apiKeyInput = apiKeyInput
            initialAPIKey = apiKeyInput
        }
    }
    
    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case delegate(Delegate)
        case onAppear
        case updateButtonTapped
        
        @CasePathable
        public enum Delegate {
            case updated
        }
    }
    
    @Dependency(\.apiKeyClient) private var apiKeyClient
    
    public init() {}
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .binding:
                return .none

            case .delegate:
                return .none

            case .onAppear:
                state.apiKeyInput = apiKeyClient.getKey() ?? .init(rawValue: "")
                return .none

            case .updateButtonTapped:
                apiKeyClient.setKey(state.apiKeyInput)
                return .send(.delegate(.updated))
            }
        }
    }
}
