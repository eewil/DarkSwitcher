

import SwiftUI

class SettingsManager {
    static let shared = SettingsManager()

    @AppStorage("autoModeEnabled") var autoModeEnabled: Bool = false
    @AppStorage("startHour") var startHour: Int = 18
    @AppStorage("endHour") var endHour: Int = 7
}
