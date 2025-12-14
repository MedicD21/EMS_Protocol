# EMS Protocol Application - Complete Setup Guide

This guide will help you set up and run the EMS Protocol native iOS application.

## Table of Contents
1. [Prerequisites](#prerequisites)
2. [Quick Start](#quick-start)
3. [Detailed Setup](#detailed-setup)
4. [Creating Xcode Project from Scratch](#creating-xcode-project-from-scratch)
5. [Configuration](#configuration)
6. [Running the App](#running-the-app)
7. [Common Issues](#common-issues)

## Prerequisites

### Required
- **macOS**: Version 12.0 (Monterey) or later
- **Xcode**: Version 14.0 or later
  - Download from Mac App Store or [Apple Developer](https://developer.apple.com/xcode/)
- **Apple ID**: For signing the app (free account works for development)

### Optional
- **Apple Developer Account**: Required for TestFlight and App Store distribution
- **iOS Device**: For testing on real hardware (iPhone/iPad)
- **VS Code**: For code editing outside Xcode

## Quick Start

### Option 1: Using Xcode (Fastest)

```bash
# Navigate to the iOS directory
cd ios-native

# Create a new Xcode project (if .xcodeproj doesn't exist)
# Then open Xcode and follow the steps in "Creating Xcode Project from Scratch"

# Or if you already have the project:
open EMS_Protocol.xcodeproj

# Build and run with ⌘R
```

## Detailed Setup

### Step 1: Verify Xcode Installation

```bash
# Check Xcode version
xcodebuild -version

# Should show:
# Xcode 14.0 or later
# Build version XXXXX
```

If Xcode is not installed:
1. Open Mac App Store
2. Search for "Xcode"
3. Click "Get" or "Install"
4. Wait for download (8-12 GB)

### Step 2: Install Command Line Tools

```bash
xcode-select --install
```

If already installed, you'll see: "command line tools are already installed"

### Step 3: Verify Swift Installation

```bash
swift --version

# Should show:
# swift-driver version X.X.X
# Apple Swift version 5.7 or later
```

## Creating Xcode Project from Scratch

Since you have all the Swift source files but no .xcodeproj file, follow these steps:

### Method 1: Create Project in Xcode (Recommended)

1. **Open Xcode**

2. **Create New Project**:
   - File → New → Project (or ⌘⇧N)
   - Select "iOS" tab at the top
   - Choose "App" template
   - Click "Next"

3. **Configure Project**:
   - **Product Name**: `EMS_Protocol`
   - **Team**: Select your Apple ID or "None" for now
   - **Organization Identifier**: `com.yourname` (or your preferred identifier)
   - **Bundle Identifier**: Will auto-generate as `com.yourname.EMS-Protocol`
   - **Interface**: `SwiftUI`
   - **Language**: `Swift`
   - **Storage**: `None` (we'll use our own models)
   - **Include Tests**: Optional (recommended: ✓)
   - Click "Next"

4. **Choose Location**:
   - Navigate to the `ios-native` directory
   - **IMPORTANT**: Uncheck "Create Git repository" (we already have one)
   - Click "Create"

5. **Remove Default Files**:
   - In the Project Navigator (left sidebar), select these files:
     - `ContentView.swift`
     - Any other auto-generated files
   - Right-click → Delete → "Move to Trash"

6. **Add Our Source Files**:
   - Right-click on the `EMS_Protocol` folder (with yellow icon)
   - Select "Add Files to 'EMS_Protocol'..."
   - Navigate to `ios-native/EMS_Protocol/EMS_Protocol/`
   - Select the following folders:
     - `Models`
     - `ViewModels`
     - `Views`
     - `Services`
   - **IMPORTANT**: Check these options:
     - ✓ "Copy items if needed"
     - ✓ "Create groups"
     - ✓ Add to target: "EMS_Protocol"
   - Click "Add"

7. **Add Individual Files**:
   - Add `EMS_ProtocolApp.swift` (the main app file)
   - Add `Info.plist` to the project

8. **Configure Info.plist**:
   - Select your project in the navigator
   - Select the target "EMS_Protocol"
   - Go to "Info" tab
   - If needed, add camera permissions:
     - Add Row: "Privacy - Camera Usage Description" → "Camera access is required to scan protocol documents"
     - Add Row: "Privacy - Photo Library Usage Description" → "Photo library access is required to import protocol documents"

9. **Configure Signing**:
   - Select the target "EMS_Protocol"
   - Go to "Signing & Capabilities" tab
   - Check "Automatically manage signing"
   - Select your Team (Apple ID)

10. **Build the Project**:
    - Select a simulator from the dropdown (e.g., "iPhone 14 Pro")
    - Press ⌘B to build
    - Fix any errors if they appear
    - Press ⌘R to run

### Method 2: Using Swift Package Manager (Advanced)

1. **Create Package.swift**:
   ```bash
   cd ios-native
   swift package init --type executable
   ```

2. **Edit Package.swift** to include all your Swift files

3. **Build with**:
   ```bash
   swift build
   ```

## Configuration

### 1. Bundle Identifier
- In Xcode: Project → Target → General → Bundle Identifier
- Format: `com.yourcompany.EMS-Protocol`
- Must be unique for App Store submission

### 2. Deployment Target
- Minimum iOS version: **iOS 15.0**
- Set in: Project → Target → General → Deployment Info

### 3. Capabilities (Optional)
Add these if needed:
- **iCloud** (for CloudKit sync)
- **Push Notifications** (for alerts)
- **Background Modes** (for background updates)

To add:
- Target → Signing & Capabilities → "+ Capability"

### 4. AI Service Configuration

Edit `Services/AIDocumentScanner.swift`:

```swift
struct AIServiceConfig {
    // Add your API keys here
    static let openAIAPIKey = ProcessInfo.processInfo.environment["OPENAI_API_KEY"] ?? "your-key-here"
    static let claudeAPIKey = ProcessInfo.processInfo.environment["CLAUDE_API_KEY"] ?? "your-key-here"
}
```

**Secure Method** (Recommended):
1. Add keys to Xcode environment variables
2. Or use Keychain for storage
3. Never commit API keys to git!

## Running the App

### On Simulator

1. **Select Simulator**:
   - Click device dropdown (top-left of Xcode toolbar)
   - Choose any iPhone simulator
   - Recommended: iPhone 14 Pro or iPad Pro

2. **Run**:
   - Press ⌘R
   - Or click Play button (▶) in toolbar
   - App will build, launch simulator, and run

3. **Demo Login**:
   - Username: `editor` (for editor access)
   - Username: `user` (for regular user)
   - Password: anything (demo mode)

### On Physical Device

1. **Connect iPhone/iPad**:
   - Connect via USB or WiFi
   - Trust computer on device

2. **Select Device**:
   - Device dropdown → Your device name
   - First time: Xcode will register device

3. **Run**:
   - Press ⌘R
   - App will install and launch on device

4. **Trust Developer** (First time only):
   - On device: Settings → General → VPN & Device Management
   - Tap your developer certificate
   - Tap "Trust"
   - Return to home screen and launch app

## Common Issues

### Issue 1: "Unable to boot simulator"
**Solution**:
```bash
# Reset simulator
xcrun simctl erase all

# Or in Xcode: Device → Erase All Content and Settings
```

### Issue 2: "No such module 'SwiftUI'"
**Solution**:
- Ensure deployment target is iOS 15.0+
- Clean build folder: ⌘⇧K
- Rebuild: ⌘B

### Issue 3: "Code signing error"
**Solution**:
1. Select Project → Target → Signing & Capabilities
2. Change Team to your Apple ID
3. Change Bundle Identifier to something unique
4. Try building again

### Issue 4: "Missing files" errors
**Solution**:
1. Verify all files are added to the target
2. In Project Navigator, select a file
3. Check "Target Membership" in File Inspector (right sidebar)
4. Ensure "EMS_Protocol" is checked

### Issue 5: Build takes very long
**Solution**:
- First build is always slow (15-30 minutes)
- Subsequent builds are much faster (1-2 minutes)
- Enable "Build Active Architecture Only" in Build Settings

### Issue 6: "SwiftUI Preview not working"
**Solution**:
- Previews may not work for all views
- Use simulator instead for testing
- Or: Editor → Canvas → Refresh Canvas

## Testing Features

### 1. Login
- Try both "editor" and "user" accounts
- Verify editor has edit buttons, user doesn't

### 2. Protocols
- Browse different categories
- Open a protocol and view flowchart
- Switch to "Details" view
- Check color coding by certification level

### 3. Dosing Calculator
- Enter a patient weight
- Try different units (kg/lbs)
- Select age group presets
- Select a medication
- Verify dose calculations

### 4. Procedures
- Browse procedure categories
- Open a procedure
- Check step-by-step instructions
- Verify critical steps are highlighted

### 5. Medications
- Browse medication classes
- Open a medication
- Check all sections load
- Verify dosing protocols

## Next Steps

### For Development
1. ✅ Set up the project (you're here!)
2. Add custom protocols for your agency
3. Configure AI backend integration
4. Implement data persistence (CoreData/CloudKit)
5. Test thoroughly on devices

### For Production
1. Complete all features
2. Add comprehensive error handling
3. Implement analytics (optional)
4. Create app icons and screenshots
5. Prepare for App Store submission

## Additional Resources

- [Apple Developer Documentation](https://developer.apple.com/documentation/)
- [SwiftUI Tutorials](https://developer.apple.com/tutorials/swiftui)
- [iOS Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/ios)
- [App Store Review Guidelines](https://developer.apple.com/app-store/review/guidelines/)

## Support

If you encounter issues not covered here:
1. Check Xcode's error messages carefully
2. Clean build folder (⌘⇧K) and rebuild
3. Restart Xcode
4. Restart your Mac (sometimes helps!)
5. Check Apple Developer Forums

---

**Ready to build?** Open Xcode and start creating! 🚀
