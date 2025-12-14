# EMS Protocol Application

A comprehensive Emergency Medical Services protocol application with AI-powered document scanning, interactive flowcharts, and dynamic drug dosing calculations.

## 🚀 Quick Start

**Native iOS App (Recommended)**:
```bash
cd ios-native
# Follow instructions in ios-native/README.md to open in Xcode
# Or see SETUP_GUIDE.md for detailed setup instructions
```

## ✨ Features

### Core Functionality
- **AI Document Scanning**: Automatically scan and format EMS protocols from documents using Vision and AI
- **Interactive Flowcharts**: Visual flow-style charts for easy protocol navigation
- **Color-Coded Certification Levels**:
  - 🟢 EMR (Emergency Medical Responder) - Green
  - 🔵 EMT (Emergency Medical Technician) - Blue
  - 🟡 AEMT (Advanced EMT) - Yellow
  - 🔴 Paramedic - Red
- **National Model EMS Clinical Guidelines**: Based on current national standards
- **State-Specific Customization**: AI-tailored protocols for state-specific regulations
- **Dynamic Drug Dosing Calculator**: Weight-based calculations updated in real-time
  - Global weight input (kg or lbs)
  - Age group presets
  - Automatic dose calculations
  - Maximum dose warnings
- **Procedures Library**: Comprehensive step-by-step procedures for all certification levels
- **Pharmacology Reference**: Complete medication reference with dosing, indications, contraindications

### User Profiles
1. **Editor Profile**: Full access to create, edit, and update protocols
   - Protocol editor with flowchart builder
   - AI document scanner
   - Import/export capabilities
2. **Regular User Profile**: Read-only access to protocols and reference tools
   - Full access to dosing calculator
   - All protocols and procedures
   - Educational materials

## 📱 Native iOS Application

The app is built with SwiftUI and includes:

- ✅ Complete working iOS application
- ✅ All source code included
- ✅ Sample data based on National Model EMS Clinical Guidelines
- ✅ 5+ complete protocols (Cardiac Arrest, Chest Pain, Respiratory Distress, etc.)
- ✅ 6+ medications with full dosing information
- ✅ 3+ procedures with step-by-step instructions
- ✅ Weight-based drug calculator
- ✅ User authentication system
- ✅ AI document scanning architecture
- ✅ State-specific customization support

### Demo Credentials
- **Editor**: username `editor` (any password)
- **Regular User**: username `user` (any password)

## 📂 Project Structure

```
EMS_Protocol/
├── ios-native/                         # ⭐ Native iOS Swift/SwiftUI app
│   ├── EMS_Protocol/
│   │   ├── EMS_ProtocolApp.swift      # Main app entry point
│   │   ├── Info.plist                  # App configuration
│   │   ├── Models/                     # Data models
│   │   │   ├── CertificationLevel.swift
│   │   │   ├── Protocol.swift
│   │   │   ├── Medication.swift
│   │   │   ├── Procedure.swift
│   │   │   ├── User.swift
│   │   │   └── SampleData.swift       # National Model EMS data
│   │   ├── ViewModels/                 # Business logic
│   │   │   ├── AuthenticationManager.swift
│   │   │   ├── ProtocolStore.swift
│   │   │   └── DosingCalculator.swift
│   │   ├── Views/                      # UI components
│   │   │   ├── LoginView.swift
│   │   │   ├── MainTabView.swift
│   │   │   ├── ProtocolsListView.swift
│   │   │   ├── ProtocolDetailView.swift
│   │   │   ├── ProceduresListView.swift
│   │   │   ├── PharmacologyListView.swift
│   │   │   ├── DosingCalculatorView.swift
│   │   │   ├── SettingsView.swift
│   │   │   └── ProtocolEditorView.swift
│   │   └── Services/                   # Backend services
│   │       └── AIDocumentScanner.swift
│   └── README.md                       # iOS-specific documentation
├── SETUP_GUIDE.md                      # Detailed setup instructions
└── README.md                           # This file
```

## 🛠 Technology Stack

### iOS Native (Complete Implementation)
- **SwiftUI**: Modern declarative UI framework
- **Combine**: Reactive programming for data flow
- **Vision Framework**: OCR for document scanning
- **VisionKit**: Document camera integration
- **AI Integration Points**: OpenAI/Claude API ready
- **Architecture**: MVVM pattern with ObservableObject

### Planned Backend (Integration Points Ready)
- Node.js/Express or Python/FastAPI
- PostgreSQL database
- OpenAI GPT-4 / Anthropic Claude for document processing
- State regulation database for customization

## 📚 Sample Data Included

Based on **National Model EMS Clinical Guidelines**:

### Protocols
- ❤️ Cardiac Arrest - Adult (Complete ACLS algorithm)
- 💔 Acute Coronary Syndrome / Chest Pain
- 🫁 Respiratory Distress / Asthma / COPD
- ⚠️ Anaphylaxis / Allergic Reaction
- 🧠 Stroke / CVA

### Medications
- Epinephrine (Cardiac arrest, Anaphylaxis)
- Aspirin (ACS)
- Albuterol (Bronchospasm)
- Nitroglycerin (Chest pain)
- Morphine Sulfate (Pain management)
- Amiodarone (Antiarrhythmic)

### Procedures
- Bag-Valve-Mask Ventilation
- Intravenous Access - Peripheral
- 12-Lead ECG Acquisition

## 🚀 Getting Started

### Requirements
- macOS 12.0 (Monterey) or later
- Xcode 14.0 or later
- iOS 15.0+ (deployment target)
- Apple ID (free account works for development)

### Setup (Detailed guide in SETUP_GUIDE.md)

1. **Clone or navigate to the repository**:
   ```bash
   cd ios-native
   ```

2. **Create Xcode Project**:
   - Open Xcode
   - File → New → Project → iOS → App
   - Name: "EMS_Protocol"
   - Interface: SwiftUI, Language: Swift
   - Save in `ios-native` directory

3. **Add Source Files**:
   - Right-click project → "Add Files to EMS_Protocol"
   - Select all folders (Models, ViewModels, Views, Services)
   - Check "Copy items if needed"

4. **Configure Signing**:
   - Select project → Target → Signing & Capabilities
   - Choose your Apple ID as Team

5. **Build and Run**:
   - Select iPhone simulator
   - Press ⌘R

For complete step-by-step instructions, see **[SETUP_GUIDE.md](SETUP_GUIDE.md)**

## 🎯 Key Features Explained

### 1. Interactive Flowcharts
- Color-coded by certification level
- Conditional branching for decision points
- Links to detailed information
- Educational points with references

### 2. Drug Dosing Calculator
- **Global Weight Input**: Set once, used throughout app
- **Age Presets**: Neonate, Infant, Child, Adolescent, Adult, Geriatric
- **Real-Time Calculations**: Instant dose updates
- **Safety Features**: Maximum dose warnings, contraindications

### 3. AI Document Scanner
- Uses Apple Vision framework for OCR
- Extracts text from photos or PDFs
- AI integration points for automatic protocol generation
- State-specific customization

### 4. Two-Tier User System
- **Editors**: Create, modify, delete protocols
- **Regular Users**: Read-only access, full calculator access

## 🔧 Customization

### Adding Protocols
1. Login as editor
2. Tap "+" in Protocols view
3. Build flowchart with drag-and-drop steps
4. Assign certification levels
5. Add educational points

### AI Backend Configuration
Edit `Services/AIDocumentScanner.swift`:
```swift
struct AIServiceConfig {
    static let openAIAPIKey = "your-key"
    static let claudeAPIKey = "your-key"
}
```

### State Customization
```swift
protocol.stateSpecificNotes["CA"] = "California-specific requirements"
protocol.stateSpecificNotes["TX"] = "Texas-specific requirements"
```

## 📊 Development Status

- ✅ iOS native app (Complete and functional)
- ✅ Core features (Protocols, Medications, Procedures)
- ✅ Dosing calculator (Fully functional)
- ✅ User authentication (Demo implementation)
- ✅ UI/UX (Complete with color coding)
- ✅ Sample data (National Model EMS Guidelines)
- 🔄 AI document scanning (Architecture ready, needs API key)
- 🔄 Data persistence (In-memory, CoreData ready)
- 🔄 State customization (Manual, AI integration ready)
- ⏳ Backend API (Integration points ready)
- ⏳ CloudKit sync (Optional enhancement)

## 🎓 Educational Value

Perfect for:
- EMS students learning protocols
- Paramedics reviewing procedures
- Training coordinators
- Medical directors updating protocols
- Agencies standardizing care

## 📱 Platform Support

- ✅ iPhone (iOS 15.0+)
- ✅ iPad (iPadOS 15.0+)
- 🔄 Apple Watch (planned)
- 🔄 macOS (Mac Catalyst ready)

## 🚀 Deployment

### TestFlight Beta
1. Archive app in Xcode
2. Upload to App Store Connect
3. Add testers
4. Distribute

### App Store
1. Complete all features
2. Add app icons and screenshots
3. Submit for review
4. Publish

## 📄 License

MIT License - See LICENSE file for details

## 🙏 Credits

- Based on **National Model EMS Clinical Guidelines**
- Follows AHA/ERC resuscitation guidelines 2020
- Medication data from standard EMS formularies
- Built with SwiftUI and modern iOS frameworks

## 📞 Support

- Check [SETUP_GUIDE.md](SETUP_GUIDE.md) for detailed setup
- Review [ios-native/README.md](ios-native/README.md) for iOS-specific docs
- Apple Developer Documentation: https://developer.apple.com

---

**Built with ❤️ for EMS professionals by AI-powered development**

Ready to save lives with technology! 🚑
