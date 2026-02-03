import SwiftUI
import AppKit
import LaunchAtLogin

@main
struct DarkSwitcherApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        Settings { EmptyView() }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        setupMenuBar()
        setupThemeObserver()
        updateIcon()
    }

    func setupMenuBar() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        if let button = statusItem?.button {
            button.action = #selector(mouseClickHandler)
            button.target = self
            button.sendAction(on: [.leftMouseUp, .rightMouseUp])
        }
    }
    
    @objc func mouseClickHandler(_ sender: NSStatusBarButton) {
        let event = NSApp.currentEvent!
        
        if event.type == .rightMouseUp || (event.modifierFlags.contains(.control)) {
            let menu = NSMenu()
            
            let autoLaunchItem = NSMenuItem(
                title: "Launch at login",
                action: #selector(toggleAutoLaunch),
                keyEquivalent: ""
            )
            autoLaunchItem.target = self
            
            autoLaunchItem.state = LaunchAtLogin.isEnabled ? .on : .off
            
            menu.addItem(autoLaunchItem)
            menu.addItem(NSMenuItem.separator())
            menu.addItem(NSMenuItem(title: "Quit", action: #selector(quitApp), keyEquivalent: "q"))
            
            statusItem?.menu = menu
            statusItem?.button?.performClick(nil)
            statusItem?.menu = nil
            
        } else {
            toggleTheme()
        }
    }
    
    @objc func toggleAutoLaunch() {
        LaunchAtLogin.isEnabled.toggle()
    }

    func toggleTheme() {
        let source = """
        tell application "System Events"
            tell appearance preferences
                set dark mode to not dark mode
            end tell
        end tell
        """
        DispatchQueue.global(qos: .userInitiated).async {
             NSAppleScript(source: source)?.executeAndReturnError(nil)
        }
    }
    
    func setupThemeObserver() {
        DistributedNotificationCenter.default().addObserver(
            self,
            selector: #selector(themeChanged),
            name: NSNotification.Name("AppleInterfaceThemeChangedNotification"),
            object: nil
        )
    }
    
    @objc func themeChanged() {
        DispatchQueue.main.async {
            self.updateIcon()
        }
    }

    func updateIcon() {
        let appearance = NSApp.effectiveAppearance.name
        let isDark = appearance.rawValue.contains("Dark")
        let iconName = isDark ? "moon.fill" : "sun.max.fill"
        let image = NSImage(systemSymbolName: iconName, accessibilityDescription: "Toggle Theme")
        image?.isTemplate = true
        statusItem?.button?.image = image
    }

    @objc func quitApp() {
        NSApplication.shared.terminate(nil)
    }
}
