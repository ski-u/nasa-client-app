import Models
import Sharing
import SwiftUI

struct TranslationView: View {
    @Shared(.appStorage("isTranslationEnabled")) var isTranslationEnabled = false
    
    var body: some View {
        Form {
            Button(
                action: {
                    $isTranslationEnabled.withLock {
                        $0 = true
                    }
                }
            ) {
                HStack {
                    Text("On", bundle: .module)
                        .foregroundStyle(Color.primary)
                    
                    Spacer()
                    
                    if isTranslationEnabled {
                        Image(systemName: "checkmark")
                    }
                }
            }
            
            Button(
                action: {
                    $isTranslationEnabled.withLock {
                        $0 = false
                    }
                }
            ) {
                HStack {
                    Text("Off", bundle: .module)
                        .foregroundStyle(Color.primary)
                    
                    Spacer()
                    
                    if !isTranslationEnabled {
                        Image(systemName: "checkmark")
                    }
                }
            }
        }
        .navigationTitle(Text("Machine Translation", bundle: .module))
        .navigationBarTitleDisplayMode(.inline)
    }
}
