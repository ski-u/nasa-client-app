import Dependencies
import DependenciesMacros
import Models

@DependencyClient
public struct APIClient: Sendable {
    public var fetchAstronomyPictures: @Sendable () async throws -> [AstronomyPicture]
    public var fetchTodayPicture: @Sendable () async throws -> AstronomyPicture
}

extension APIClient: TestDependencyKey {
    public static let testValue = Self()
}

public extension DependencyValues {
    var apiClient: APIClient {
        get { self[APIClient.self] }
        set { self[APIClient.self] = newValue }
    }
}
