public enum UserColorScheme: String, Sendable {
    case dark = "dark"
    case light = "light"
    case system = "system"
    
    public var displayString: String {
        switch self {
        case .dark:
            "Dark"
        case .light:
            "Light"
        case .system:
            "Automatic"
        }
    }
}
