import Models
import Sharing
import SwiftUI

struct AppearanceView: View {
    @Shared(.appStorage("colorScheme")) var userColorScheme = UserColorScheme.system
    
    var body: some View {
        Form {
            Button(
                action: {
                    $userColorScheme.withLock {
                        $0 = .light
                    }
                }
            ) {
                HStack {
                    Text("Light", bundle: .module)
                        .foregroundStyle(Color.primary)
                    
                    Spacer()
                    
                    if userColorScheme == .light {
                        Image(systemName: "checkmark")
                    }
                }
            }
            
            Button(
                action: {
                    $userColorScheme.withLock {
                        $0 = .dark
                    }
                }
            ) {
                HStack {
                    Text("Dark", bundle: .module)
                        .foregroundStyle(Color.primary)
                    
                    Spacer()
                    
                    if userColorScheme == .dark {
                        Image(systemName: "checkmark")
                    }
                }
            }
            
            Button(
                action: {
                    $userColorScheme.withLock {
                        $0 = .system
                    }
                }
            ) {
                HStack {
                    Text("Automatic", bundle: .module)
                        .foregroundStyle(Color.primary)
                    
                    Spacer()
                    
                    if userColorScheme == .system {
                        Image(systemName: "checkmark")
                    }
                }
            }
        }
        .navigationTitle(Text("Appearance", bundle: .module))
        .navigationBarTitleDisplayMode(.inline)
    }
}
