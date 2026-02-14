import APIClient
import APIKeyClient
import APIKeyClientLive
import Dependencies
import Foundation
import LocalDate
import Models

extension APIClient: DependencyKey {
    private static let apiKeyClient = APIKeyClient.liveValue
    private static let baseURL = URL(string: "https://api.nasa.gov")!
    
    public static var liveValue: Self {
        .init(
            fetchAstronomyPictures: {
                let payloads: [AstronomyPicture.Payload] = try await fetch(
                    path: "/planetary/apod",
                    queryItems: [
                        URLQueryItem(
                            name: "start_date",
                            value: LocalDate().addingMonths(-1).description
                        ),
                    ]
                )
                return payloads
                    .map(AstronomyPicture.init)
                    .reversed()
            },
            fetchTodayPicture: {
                let payload: AstronomyPicture.Payload = try await fetch(path: "/planetary/apod")
                return AstronomyPicture(payload: payload)
            }
        )
    }

    private static func fetch<T: Decodable>(
        path: String,
        queryItems: [URLQueryItem] = []
    ) async throws -> T {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)!
        urlComponents.path = path
        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: apiKeyClient.getKey()?.rawValue)
        ] + queryItems

        let (data, _) = try await URLSession.shared.data(from: urlComponents.url!)

        return try JSONDecoder().decode(T.self, from: data)
    }
}
