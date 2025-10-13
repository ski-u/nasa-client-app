import Models
import SwiftUI

extension UserColorScheme {
    var displayString: LocalizedStringKey {
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
