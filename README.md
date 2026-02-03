# DarkSwitcher 🌗

A lightweight, native macOS Menu Bar application that allows you to toggle between **Dark** and **Light** system modes with a single click.

Built with **Swift** and **AppKit** to ensure maximum performance and native look & feel.

## 🚀 Features

* **One-Click Toggle:** Left-click the menu bar icon to instantly switch themes.
* **Auto-Detection:** The icon updates automatically if the theme is changed from System Settings or another app.
* **Native UI:** Uses SF Symbols and adapts to the menu bar size perfectly.
* **Right-Click Menu:** Access secondary options (like "Quit") via right-click.

## 🛠 Installation / Building from Source

Since this app is not signed with an Apple Developer ID (yet), you need to build it yourself using Xcode.

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/danielafhe/DarkSwitcher.git
    cd DarkSwitcher
    ```

2.  **Open in Xcode:**
    Double-click on `DarkSwitcher.xcodeproj`.

3.  **Configure Signing:**
    * Click on the project root (blue icon) in the left navigator.
    * Go to **Signing & Capabilities**.
    * In the **Team** dropdown, select your personal account (or "Add Account" if empty).

4.  **Build & Run:**
    Press `Cmd + R` or click the Play button.

## ⚠️ Permissions (Important)

The first time you run the app, macOS will block it from changing the theme because it uses AppleScript events. You might see an error in the console or nothing happens.

1.  When you click the icon, a popup should appear: *"DarkSwitcher wants to control the application System Events"*.
2.  Click **OK**.

**If the popup does not appear:**
1.  Go to **System Settings** -> **Privacy & Security** -> **Automation**.
2.  Expand **DarkSwitcher** and ensure **System Events** is toggled **ON**.
3.  If developing, you might need to reset permissions via Terminal:
    ```bash
    tccutil reset AppleEvents
    ```

## 💻 Tech Stack

* **Language:** Swift 5
* **Frameworks:** SwiftUI (Entry point), AppKit (AppDelegate, NSStatusItem).
* **Scripting:** NSAppleScript (to interface with System Events).
* **Pattern:** Delegate & Observer pattern for real-time theme detection.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
