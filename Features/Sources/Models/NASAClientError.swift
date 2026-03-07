import Foundation

public enum NASAClientError: LocalizedError {
    case missingAPIKey
    
    public var errorDescription: String? {
        switch self {
        case .missingAPIKey:
            String(
                localized: "API key configuration is required in the Settings tab to retrieve data",
                bundle: .module,
            )
        }
    }
}
