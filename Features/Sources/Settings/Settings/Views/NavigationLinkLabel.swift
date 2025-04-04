import SwiftUI

struct NavigationLinkLabel: View {
    let color: Color
    let text: Text
    let icon: Image
    
    var body: some View {
        Label {
            text
        } icon: {
            Image(systemName: "square.fill")
                .font(.title2)
                .foregroundColor(color)
                .overlay {
                    icon
                        .font(.footnote)
                        .foregroundColor(.white)
                }
        }
    }
}
