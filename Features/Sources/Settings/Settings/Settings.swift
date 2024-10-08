import ComposableArchitecture

@Reducer
public struct Settings {
    @Reducer(state: .equatable)
    public enum Path {
        case apiKeySetting(APIKeySetting)
    }

    @ObservableState
    public struct State: Equatable {
        var path = StackState<Path.State>()

        public init() {}
    }

    public enum Action {
        case path(StackActionOf<Path>)
        case popToRoot
    }

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .path(action):
                switch action {
                case let .element(id: id, action: .apiKeySetting(.updateButtonTapped)):
                    state.path.pop(from: id)
                    return .none

                default:
                    return .none
                }

            case .popToRoot:
                state.path.removeAll()
                return .none
            }
        }
        .forEach(\.path, action: \.path)
    }

    public init() {}
}
