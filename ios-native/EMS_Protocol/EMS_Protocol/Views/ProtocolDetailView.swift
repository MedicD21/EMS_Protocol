//
//  ProtocolDetailView.swift
//  EMS Protocol
//
//  Created by Claude Code
//

import SwiftUI

struct ProtocolDetailView: View {
    let `protocol`: EMSProtocol
    @EnvironmentObject var authManager: AuthenticationManager
    @EnvironmentObject var protocolStore: ProtocolStore
    @State private var showingFlowchart = true
    @State private var showingEditor = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(`protocol`.title)
                            .font(.title)
                            .fontWeight(.bold)

                        Spacer()

                        if authManager.currentUser?.role.canEdit == true {
                            Button(action: { showingEditor = true }) {
                                Image(systemName: "pencil")
                                    .foregroundColor(.blue)
                            }
                        }
                    }

                    HStack {
                        CertificationBadge(level: `protocol`.certificationLevel)

                        Text(`protocol`.category.rawValue)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                    }

                    Text("Last updated: \(formattedDate(`protocol`.lastUpdated)) • Version \(`protocol`.version)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding()

                // Toggle between Flowchart and Details
                Picker("View Mode", selection: $showingFlowchart) {
                    Text("Flowchart").tag(true)
                    Text("Details").tag(false)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)

                if showingFlowchart {
                    // Flowchart View
                    FlowchartView(steps: `protocol`.flowchartSteps)
                        .padding()
                } else {
                    // Detailed View
                    VStack(alignment: .leading, spacing: 20) {
                        // Description
                        SectionView(title: "Description") {
                            Text(`protocol`.detailedDescription)
                                .font(.body)
                        }

                        // Educational Points
                        if !`protocol`.educationalPoints.isEmpty {
                            SectionView(title: "Educational Points") {
                                ForEach(`protocol`.educationalPoints) { point in
                                    EducationalPointView(point: point)
                                }
                            }
                        }

                        // Related Procedures
                        if !`protocol`.relatedProcedures.isEmpty {
                            SectionView(title: "Related Procedures") {
                                ForEach(relatedProcedures, id: \.id) { procedure in
                                    NavigationLink(destination: ProcedureDetailView(procedure: procedure)) {
                                        Text(procedure.name)
                                            .foregroundColor(.blue)
                                    }
                                }
                            }
                        }

                        // Related Medications
                        if !`protocol`.relatedMedications.isEmpty {
                            SectionView(title: "Related Medications") {
                                ForEach(relatedMedications, id: \.id) { medication in
                                    NavigationLink(destination: MedicationDetailView(medication: medication)) {
                                        Text(medication.name)
                                            .foregroundColor(.blue)
                                    }
                                }
                            }
                        }

                        // State-Specific Notes
                        if let stateNote = stateSpecificNote {
                            SectionView(title: "State-Specific Notes") {
                                Text(stateNote)
                                    .font(.body)
                                    .padding()
                                    .background(Color.yellow.opacity(0.1))
                                    .cornerRadius(8)
                            }
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showingEditor) {
            ProtocolEditorView(protocol: `protocol`)
                .environmentObject(protocolStore)
                .environmentObject(authManager)
        }
    }

    private var relatedProcedures: [Procedure] {
        protocolStore.procedures.filter { procedure in
            `protocol`.relatedProcedures.contains(procedure.id.uuidString)
        }
    }

    private var relatedMedications: [Medication] {
        protocolStore.medications.filter { medication in
            `protocol`.relatedMedications.contains(medication.id.uuidString)
        }
    }

    private var stateSpecificNote: String? {
        guard let state = authManager.currentUser?.state else { return nil }
        return `protocol`.stateSpecificNotes[state]
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

struct FlowchartView: View {
    let steps: [FlowchartStep]

    var body: some View {
        VStack(spacing: 16) {
            ForEach(steps.sorted(by: { $0.order < $1.order })) { step in
                FlowchartStepView(step: step)

                if step.order < steps.count {
                    FlowchartArrow()
                }
            }
        }
    }
}

struct FlowchartStepView: View {
    let step: FlowchartStep

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(step.stepType.rawValue)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(step.certificationLevel.color)
                    .cornerRadius(6)

                Spacer()

                CertificationBadge(level: step.certificationLevel, size: .small)
            }

            Text(step.content)
                .font(.body)
                .fixedSize(horizontal: false, vertical: true)

            if step.isConditional && !step.conditions.isEmpty {
                VStack(alignment: .leading, spacing: 4) {
                    ForEach(step.conditions, id: \.condition) { condition in
                        HStack {
                            Image(systemName: "arrow.turn.down.right")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text("If \(condition.condition)")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .padding(.top, 4)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(step.certificationLevel.color, lineWidth: 2)
        )
        .cornerRadius(12)
    }
}

struct FlowchartArrow: View {
    var body: some View {
        VStack(spacing: 2) {
            Rectangle()
                .fill(Color.secondary)
                .frame(width: 2, height: 20)

            Image(systemName: "arrowtriangle.down.fill")
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}

struct CertificationBadge: View {
    let level: CertificationLevel
    var size: BadgeSize = .normal

    enum BadgeSize {
        case small, normal

        var fontSize: Font {
            switch self {
            case .small: return .caption2
            case .normal: return .caption
            }
        }

        var padding: EdgeInsets {
            switch self {
            case .small: return EdgeInsets(top: 2, leading: 6, bottom: 2, trailing: 6)
            case .normal: return EdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12)
            }
        }
    }

    var body: some View {
        Text(level.rawValue)
            .font(size.fontSize)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .padding(size.padding)
            .background(level.color)
            .cornerRadius(8)
    }
}

struct SectionView<Content: View>: View {
    let title: String
    let content: Content

    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.title3)
                .fontWeight(.semibold)

            content
        }
    }
}

struct EducationalPointView: View {
    let point: EducationalPoint

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(point.title)
                .font(.headline)

            Text(point.content)
                .font(.body)

            if !point.references.isEmpty {
                VStack(alignment: .leading, spacing: 4) {
                    Text("References:")
                        .font(.caption)
                        .fontWeight(.semibold)

                    ForEach(point.references, id: \.self) { reference in
                        Text("• \(reference)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
}
