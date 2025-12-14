//
//  ProtocolEditorView.swift
//  EMS Protocol
//
//  Created by Claude Code
//

import SwiftUI

struct ProtocolEditorView: View {
    @EnvironmentObject var protocolStore: ProtocolStore
    @EnvironmentObject var authManager: AuthenticationManager
    @Environment(\.presentationMode) var presentationMode

    let `protocol`: EMSProtocol?
    @State private var title: String
    @State private var category: ProtocolCategory
    @State private var certificationLevel: CertificationLevel
    @State private var detailedDescription: String
    @State private var flowchartSteps: [FlowchartStep]
    @State private var version: String

    init(protocol: EMSProtocol?) {
        self.protocol = `protocol`
        _title = State(initialValue: `protocol`?.title ?? "")
        _category = State(initialValue: `protocol`?.category ?? .general)
        _certificationLevel = State(initialValue: `protocol`?.certificationLevel ?? .emt)
        _detailedDescription = State(initialValue: `protocol`?.detailedDescription ?? "")
        _flowchartSteps = State(initialValue: `protocol`?.flowchartSteps ?? [])
        _version = State(initialValue: `protocol`?.version ?? "1.0")
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Basic Information")) {
                    TextField("Protocol Title", text: $title)

                    Picker("Category", selection: $category) {
                        ForEach(ProtocolCategory.allCases, id: \.self) { cat in
                            Text(cat.rawValue).tag(cat)
                        }
                    }

                    Picker("Minimum Certification Level", selection: $certificationLevel) {
                        ForEach(CertificationLevel.allCases) { level in
                            Text(level.displayName).tag(level)
                        }
                    }

                    TextField("Version", text: $version)
                }

                Section(header: Text("Description")) {
                    TextEditor(text: $detailedDescription)
                        .frame(minHeight: 100)
                }

                Section(header: Text("Flowchart Steps")) {
                    ForEach(flowchartSteps.indices, id: \.self) { index in
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text("Step \(index + 1)")
                                    .fontWeight(.semibold)

                                Spacer()

                                Button(action: {
                                    flowchartSteps.remove(at: index)
                                }) {
                                    Image(systemName: "trash")
                                        .foregroundColor(.red)
                                }
                            }

                            Picker("Type", selection: $flowchartSteps[index].stepType) {
                                ForEach([StepType.assessment, .intervention, .medication, .decision, .transport, .documentation], id: \.self) { type in
                                    Text(type.rawValue).tag(type)
                                }
                            }

                            Picker("Certification", selection: $flowchartSteps[index].certificationLevel) {
                                ForEach(CertificationLevel.allCases) { level in
                                    Text(level.rawValue).tag(level)
                                }
                            }

                            TextEditor(text: $flowchartSteps[index].content)
                                .frame(minHeight: 60)
                                .border(Color.gray.opacity(0.2))
                        }
                        .padding(.vertical, 8)
                    }

                    Button(action: addStep) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                            Text("Add Step")
                        }
                        .foregroundColor(.blue)
                    }
                }

                Section {
                    Button(action: saveProtocol) {
                        HStack {
                            Spacer()
                            Text("Save Protocol")
                                .fontWeight(.semibold)
                            Spacer()
                        }
                    }
                    .disabled(title.isEmpty || detailedDescription.isEmpty)
                }
            }
            .navigationTitle(`protocol` == nil ? "New Protocol" : "Edit Protocol")
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }

    private func addStep() {
        let newStep = FlowchartStep(
            order: flowchartSteps.count + 1,
            stepType: .assessment,
            content: "",
            certificationLevel: certificationLevel
        )
        flowchartSteps.append(newStep)
    }

    private func saveProtocol() {
        // Reorder steps
        for (index, _) in flowchartSteps.enumerated() {
            flowchartSteps[index].order = index + 1
        }

        if let existingProtocol = `protocol` {
            // Update existing protocol
            var updatedProtocol = existingProtocol
            updatedProtocol.title = title
            updatedProtocol.category = category
            updatedProtocol.certificationLevel = certificationLevel
            updatedProtocol.detailedDescription = detailedDescription
            updatedProtocol.flowchartSteps = flowchartSteps
            updatedProtocol.version = version
            updatedProtocol.lastUpdated = Date()

            protocolStore.updateProtocol(updatedProtocol)
        } else {
            // Create new protocol
            let newProtocol = EMSProtocol(
                title: title,
                category: category,
                certificationLevel: certificationLevel,
                flowchartSteps: flowchartSteps,
                detailedDescription: detailedDescription,
                educationalPoints: [],
                version: version
            )

            protocolStore.addProtocol(newProtocol)
        }

        presentationMode.wrappedValue.dismiss()
    }
}
