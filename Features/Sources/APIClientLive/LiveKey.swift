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
    
    // TODO: API request abstraction
    public static var liveValue: Self {
        .init(
            fetchAstronomyPictures: {
                var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)!
                urlComponents.path = "/planetary/apod"
                urlComponents.queryItems = [
                    URLQueryItem(name: "api_key", value: apiKeyClient.getKey()?.rawValue),
                    URLQueryItem(
                        name: "start_date",
                        value: LocalDate().addingMonths(-1).description
                    ),
                ]
                
                let (data, _) = try await URLSession.shared.data(from: urlComponents.url!)
                
                return try JSONDecoder()
                    .decode([AstronomyPicture.Payload].self, from: data)
                    .map(AstronomyPicture.init)
                    .reversed()
            },
            fetchTodayPicture: {
                // As NASA isn't providing the latest APOD now (as of 2025/10/15), return fixed image temporarily.
                try await Task.sleep(for: .seconds(2))
                
                return .init(
                    copyright: "Bray FallsKeith Quattrocchi",
                    date: LocalDate(year: 2012, month: 7, day: 12),
                    explanation:
                        "What will become of our Sun? The first hint of our Sun's future was discovered inadvertently in 1764. At that time, Charles Messier was compiling a list of diffuse objects not to be confused with comets. The 27th object on Messier's list, now known as M27 or the Dumbbell Nebula, is a planetary nebula, one of the brightest planetary nebulae on the sky -- and visible toward the constellation of the Fox (Vulpecula) with binoculars. It takes light about 1000 years to reach us from M27, featured here in colors emitted by hydrogen and oxygen. We now know that in about 6 billion years, our Sun will shed its outer gases into a planetary nebula like M27, while its remaining center will become an X-ray hot white dwarf star.  Understanding the physics and significance of M27 was well beyond 18th century science, though. Even today, many things remain mysterious about planetary nebulas, including how their intricate shapes are created.",
                    hdURL: URL(
                        string: "https://apod.nasa.gov/apod/image/2107/M27_Falls_3557.jpg"
                    )!,
                    mediaType: .image,
                    title: "M27: The Dumbbell Nebula",
                    url: URL(string: "https://apod.nasa.gov/apod/image/2107/M27_Falls_960.jpg")!
                )
            }
        )
    }
}
