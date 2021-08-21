
import Foundation
import SwiftUI

public struct DarkModeViewModifier: ViewModifier
{
@AppStorage("isDarkMode") var isDarkMode: Bool = true
    public func body(content: Content) -> some View {
        content
            .environment(\.colorScheme, isDarkMode ? .dark : .light)
            .preferredColorScheme(isDarkMode ? .dark : .light)
        }
}
