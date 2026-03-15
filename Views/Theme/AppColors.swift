import SwiftUI

#if os(macOS)
import AppKit
#else
import UIKit
#endif

extension Color {
    static var appSystemBackground: Color {
        #if os(macOS)
        return Color(nsColor: .windowBackgroundColor)
        #else
        return Color(uiColor: .systemBackground)
        #endif
    }

    static var appSecondaryBackground: Color {
        #if os(macOS)
        return Color(nsColor: .controlBackgroundColor)
        #else
        return Color(uiColor: .secondarySystemBackground)
        #endif
    }

    static var appTertiaryFill: Color {
        #if os(macOS)
        return Color(nsColor: .quaternaryLabelColor).opacity(0.3)
        #else
        return Color(uiColor: .tertiarySystemFill)
        #endif
    }
}
