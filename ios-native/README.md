# EMS Protocol - Native iOS Application

A comprehensive EMS protocol application built with SwiftUI for iOS devices.

## Features

### Core Functionality
- **Interactive Protocol Flowcharts**: Visual, color-coded flowcharts for all EMS protocols
- **Certification-Level Filtering**: Content automatically filtered by user certification level
  - EMR (Green)
  - EMT (Blue)
  - AEMT (Yellow)
  - Paramedic (Red)
- **Dynamic Drug Dosing Calculator**: Real-time weight-based calculations for all medications
- **Comprehensive Pharmacology Reference**: Complete medication database with dosing, indications, contraindications
- **Procedure Library**: Step-by-step procedures with critical points highlighted
- **AI Document Scanner**: Scan protocol documents and automatically generate flowcharts
- **State-Specific Customization**: Protocols tailored to state-specific regulations
- **Dual User Modes**: Editor and Regular User profiles

### Based on National Model EMS Clinical Guidelines
- Cardiac protocols
- Respiratory protocols
- Trauma protocols
- Medical emergencies
- Pediatric protocols
- Obstetric protocols
- Environmental emergencies
- Toxicological emergencies
- Behavioral emergencies

## Requirements

- iOS 15.0 or later
- Xcode 14.0 or later
- Swift 5.7 or later

## Setup Instructions

### Option 1: Open in Xcode (Recommended)

1. **Open the project in Xcode**:
   ```bash
   cd ios-native
   open EMS_Protocol.xcodeproj
   ```

   If the .xcodeproj file doesn't exist yet, you can create it:
   - Open Xcode
   - File → New → Project
   - Choose "iOS" → "App"
   - Product Name: "EMS_Protocol"
   - Organization Identifier: "com.yourcompany" (change as needed)
   - Interface: SwiftUI
   - Language: Swift
   - Save in the `ios-native` directory

2. **Add the source files to your project**:
   - In Xcode, right-click on the project navigator
   - Choose "Add Files to EMS_Protocol"
   - Select the `EMS_Protocol` folder containing all Swift files
   - Make sure "Copy items if needed" is checked
   - Click "Add"

3. **Configure the Info.plist**:
   - The Info.plist file is already configured with necessary permissions
   - Review camera and photo library usage descriptions

4. **Set your bundle identifier**:
   - Select the project in the navigator
   - Go to "Signing & Capabilities"
   - Set your Team
   - Update Bundle Identifier if needed

5. **Build and Run**:
   - Select your target device or simulator
   - Press ⌘R or click the Play button

### Option 2: Transfer to VS Code

1. **Copy the entire `ios-native` folder to your local machine**

2. **Open in VS Code**:
   ```bash
   cd ios-native
   code .
   ```

3. **Install Swift extension for VS Code** (optional):
   - Swift Language Support
   - Swift Lint

4. **Edit files in VS Code**

5. **When ready to build, open in Xcode**:
   ```bash
   open EMS_Protocol.xcodeproj
   ```

## Project Structure

```
EMS_Protocol/
├── EMS_Protocol/
│   ├── EMS_ProtocolApp.swift          # Main app entry point
│   ├── Info.plist                      # App configuration
│   │
│   ├── Models/                         # Data models
│   │   ├── CertificationLevel.swift
│   │   ├── Protocol.swift
│   │   ├── Medication.swift
│   │   ├── Procedure.swift
│   │   ├── User.swift
│   │   └── SampleData.swift
│   │
│   ├── ViewModels/                     # Business logic
│   │   ├── AuthenticationManager.swift
│   │   ├── ProtocolStore.swift
│   │   └── DosingCalculator.swift
│   │
│   ├── Views/                          # UI components
│   │   ├── LoginView.swift
│   │   ├── MainTabView.swift
│   │   ├── ProtocolsListView.swift
│   │   ├── ProtocolDetailView.swift
│   │   ├── ProceduresListView.swift
│   │   ├── PharmacologyListView.swift
│   │   ├── DosingCalculatorView.swift
│   │   ├── SettingsView.swift
│   │   └── ProtocolEditorView.swift
│   │
│   ├── Services/                       # Backend services
│   │   └── AIDocumentScanner.swift
│   │
│   └── Resources/                      # Assets and resources
│
└── README.md
```

## Key Features Explained

### 1. User Authentication
- Two user roles: **Editor** and **Regular User**
- Editors can create, edit, and delete protocols
- Regular users have read-only access
- Demo credentials:
  - Editor: username "editor", any password
  - User: username "user", any password

### 2. Protocol Flowcharts
- Interactive, color-coded flowcharts
- Each step shows certification level required
- Conditional branching for decision points
- Links to detailed information
- Educational points with references

### 3. Drug Dosing Calculator
- Global weight input (kg or lbs)
- Age group presets (Neonate, Infant, Child, Adolescent, Adult, Geriatric)
- Real-time dose calculations
- Weight-based and fixed dosing
- Maximum dose warnings
- Instructions for each medication

### 4. AI Document Scanner
- Scan protocol documents with camera or from library
- OCR text extraction using Vision framework
- AI-powered protocol generation (requires backend configuration)
- State-specific customization

### 5. State-Specific Protocols
- Protocols can be customized per state
- State-specific notes highlighted
- AI integration for automatic state regulation compliance (requires backend)

## AI Integration

The app includes architecture for AI-powered features:

### Document Scanning
- Uses Apple's Vision framework for OCR
- Backend integration points for AI protocol generation
- Supports OpenAI GPT-4, Claude, or custom models

### To Configure AI Backend:

1. Edit `Services/AIDocumentScanner.swift`
2. Add your API keys in `AIServiceConfig`:
   ```swift
   static let openAIAPIKey = "your-key-here"
   static let claudeAPIKey = "your-key-here"
   ```
3. Implement the `callAIAPI` method with your preferred AI service
4. Consider using environment variables or Keychain for secure storage

### Example AI Prompt Structure:
```swift
let prompt = """
You are an expert EMS protocol analyzer. Parse the following protocol and extract:
1. Title and category
2. Certification level requirements
3. Step-by-step flowchart instructions
4. Educational points
5. Related medications

Document text: \(extractedText)
"""
```

## Customization

### Adding New Protocols
1. As an Editor user, tap the "+" button in Protocols view
2. Fill in protocol details
3. Add flowchart steps with certification levels
4. Save protocol

### Adding New Medications
1. Edit `Models/SampleData.swift`
2. Add new `Medication` to `sampleMedications` array
3. Include all dosing protocols

### Adding New Procedures
1. Edit `Models/SampleData.swift`
2. Add new `Procedure` to `sampleProcedures` array
3. Include step-by-step instructions

### State-Specific Customization
Edit protocols to add state-specific notes:
```swift
protocol.stateSpecificNotes["CA"] = "California-specific note"
protocol.stateSpecificNotes["TX"] = "Texas-specific note"
```

## Data Persistence

Currently uses in-memory storage. To implement persistence:

### Option 1: UserDefaults (Simple)
- Good for small amounts of data
- Modify `ProtocolStore` to save/load from UserDefaults

### Option 2: CoreData (Recommended)
- Full database capabilities
- Create CoreData model matching existing structures
- Modify ViewModels to use CoreData

### Option 3: CloudKit (Advanced)
- Sync across devices
- Requires iCloud configuration
- Best for multi-device support

## Testing

### Demo Accounts
- **Editor**: username "editor" (any password)
  - Can create, edit, delete protocols
  - Access to document scanner
  - Can export/import data

- **Regular User**: username "user" (any password)
  - Read-only access to protocols
  - Can use dosing calculator
  - Can view all reference materials

### Sample Data
The app includes comprehensive sample data:
- 5+ complete protocols (Cardiac Arrest, Chest Pain, Respiratory Distress, Anaphylaxis, Stroke)
- 6+ medications (Epinephrine, Aspirin, Albuterol, Nitroglycerin, Morphine, Amiodarone)
- 3+ procedures (BVM, IV Access, 12-Lead ECG)

## Deployment

### App Store Deployment
1. Ensure you have an Apple Developer account
2. Configure bundle identifier and signing
3. Archive the app (Product → Archive)
4. Upload to App Store Connect
5. Submit for review

### TestFlight Beta
1. Archive the app
2. Upload to App Store Connect
3. Add beta testers
4. Distribute builds

## Troubleshooting

### Build Issues
- Clean build folder: ⌘⇧K
- Restart Xcode
- Update to latest Xcode version
- Check Swift version compatibility

### Common Errors
- **Missing files**: Ensure all Swift files are added to target
- **Bundle identifier issues**: Update in project settings
- **Signing errors**: Configure your development team

### Performance
- Sample data is loaded on app launch
- For production, implement lazy loading
- Consider pagination for large datasets

## Future Enhancements

- [ ] CoreData integration for persistence
- [ ] CloudKit sync across devices
- [ ] Offline mode support
- [ ] Export protocols as PDF
- [ ] Print functionality
- [ ] Dark mode optimization
- [ ] iPad-specific layouts
- [ ] Apple Watch companion app
- [ ] Voice commands with Siri integration
- [ ] AR visualization for procedures
- [ ] Complete AI backend integration
- [ ] Multi-language support

## Support

For issues or questions:
1. Check this README
2. Review inline code comments
3. Check Apple Developer Documentation
4. SwiftUI Documentation: https://developer.apple.com/documentation/swiftui

## License

MIT License - See LICENSE file for details

## Credits

- Based on National Model EMS Clinical Guidelines
- Follows AHA/ERC resuscitation guidelines
- Medication data from standard EMS formularies

---

Built with ❤️ for EMS professionals
