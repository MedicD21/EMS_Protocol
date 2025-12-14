//
//  PharmacologyListView.swift
//  EMS Protocol
//
//  Created by Claude Code
//

import SwiftUI

struct PharmacologyListView: View {
    @EnvironmentObject var authManager: AuthenticationManager
    @EnvironmentObject var protocolStore: ProtocolStore
    @State private var selectedClassification: MedicationClass?
    @State private var showingAddMedication = false

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                SearchBar(text: $protocolStore.searchQuery)
                    .padding(.horizontal)
                    .padding(.vertical, 8)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        CategoryFilterButton(
                            title: "All",
                            isSelected: selectedClassification == nil,
                            action: { selectedClassification = nil }
                        )

                        ForEach(MedicationClass.allCases, id: \.self) { classification in
                            CategoryFilterButton(
                                title: classification.rawValue,
                                isSelected: selectedClassification == classification,
                                action: { selectedClassification = classification }
                            )
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                }
                .background(Color(.systemGray6))

                List {
                    ForEach(filteredMedications) { medication in
                        NavigationLink(destination: MedicationDetailView(medication: medication)) {
                            MedicationRowView(medication: medication)
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Pharmacology")
            .navigationBarItems(trailing: HStack {
                if authManager.currentUser?.role.canEdit == true {
                    Button(action: { showingAddMedication = true }) {
                        Image(systemName: "plus")
                    }
                }
            })
        }
    }

    private var filteredMedications: [Medication] {
        var filtered = protocolStore.getMedications(certificationLevel: authManager.currentUser?.certificationLevel)

        if let classification = selectedClassification {
            filtered = filtered.filter { $0.classification == classification }
        }

        return filtered
    }
}

struct MedicationRowView: View {
    let medication: Medication

    var body: some View {
        HStack(spacing: 12) {
            RoundedRectangle(cornerRadius: 4)
                .fill(medication.certificationLevel.color)
                .frame(width: 6)

            VStack(alignment: .leading, spacing: 4) {
                Text(medication.name)
                    .font(.headline)

                Text(medication.genericName)
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                HStack {
                    Text(medication.classification.rawValue)
                        .font(.caption)
                        .foregroundColor(.secondary)

                    Text("•")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    Text(medication.certificationLevel.rawValue)
                        .font(.caption)
                        .foregroundColor(medication.certificationLevel.color)
                        .fontWeight(.semibold)
                }
            }
            .padding(.vertical, 8)

            Spacer()

            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}

struct MedicationDetailView: View {
    let medication: Medication
    @EnvironmentObject var authManager: AuthenticationManager
    @EnvironmentObject var dosingCalculator: DosingCalculator

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header
                VStack(alignment: .leading, spacing: 8) {
                    Text(medication.name)
                        .font(.title)
                        .fontWeight(.bold)

                    Text("Generic: \(medication.genericName)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    if !medication.brandNames.isEmpty {
                        Text("Brand Names: \(medication.brandNames.joined(separator: ", "))")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }

                    HStack {
                        CertificationBadge(level: medication.certificationLevel)

                        Text(medication.classification.rawValue)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                    }
                }
                .padding()

                Divider()

                // Quick Dosing
                SectionView(title: "Quick Dosing") {
                    MedicationDosingCard(medication: medication)
                        .environmentObject(dosingCalculator)
                }
                .padding(.horizontal)

                Divider()

                // Mechanism of Action
                SectionView(title: "Mechanism of Action") {
                    Text(medication.mechanismOfAction)
                        .font(.body)
                }
                .padding(.horizontal)

                Divider()

                // Indications
                SectionView(title: "Indications") {
                    ForEach(medication.indications, id: \.self) { indication in
                        BulletPointView(text: indication)
                    }
                }
                .padding(.horizontal)

                // Contraindications
                if !medication.contraindications.isEmpty {
                    Divider()

                    SectionView(title: "Contraindications") {
                        ForEach(medication.contraindications, id: \.self) { contraindication in
                            BulletPointView(text: contraindication, color: .red)
                        }
                    }
                    .padding(.horizontal)
                }

                // Precautions
                if !medication.precautions.isEmpty {
                    Divider()

                    SectionView(title: "Precautions") {
                        ForEach(medication.precautions, id: \.self) { precaution in
                            BulletPointView(text: precaution, color: .orange)
                        }
                    }
                    .padding(.horizontal)
                }

                // Dosing Details
                Divider()

                SectionView(title: "Dosing Protocols") {
                    ForEach(medication.dosing) { dosing in
                        DosingProtocolCard(dosing: dosing)
                    }
                }
                .padding(.horizontal)

                // Routes
                Divider()

                SectionView(title: "Administration Routes") {
                    ForEach(medication.routes, id: \.self) { route in
                        BulletPointView(text: route.rawValue)
                    }
                }
                .padding(.horizontal)

                // Pharmacokinetics
                Divider()

                SectionView(title: "Pharmacokinetics") {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("Onset:")
                                .fontWeight(.semibold)
                            Text(medication.onset)
                        }

                        HStack {
                            Text("Duration:")
                                .fontWeight(.semibold)
                            Text(medication.duration)
                        }
                    }
                }
                .padding(.horizontal)

                // Adverse Effects
                if !medication.adverseEffects.isEmpty {
                    Divider()

                    SectionView(title: "Adverse Effects") {
                        ForEach(medication.adverseEffects, id: \.self) { effect in
                            BulletPointView(text: effect, color: .secondary)
                        }
                    }
                    .padding(.horizontal)
                }

                // State-Specific Notes
                if let stateNote = stateSpecificNote {
                    Divider()

                    SectionView(title: "State-Specific Notes") {
                        Text(stateNote)
                            .font(.body)
                            .padding()
                            .background(Color.yellow.opacity(0.1))
                            .cornerRadius(8)
                    }
                    .padding(.horizontal)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }

    private var stateSpecificNote: String? {
        guard let state = authManager.currentUser?.state else { return nil }
        return medication.stateSpecificNotes[state]
    }
}

struct DosingProtocolCard: View {
    let dosing: DosingProtocol

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(dosing.doseType.rawValue)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.blue)
                    .cornerRadius(6)

                Text(dosing.patientAgeGroup.rawValue)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Text("Indication: \(dosing.indication)")
                .font(.subheadline)
                .fontWeight(.semibold)

            HStack {
                Text("Dose:")
                    .foregroundColor(.secondary)
                Text("\(String(format: "%.2f", dosing.amount)) \(dosing.unit.rawValue)")
                    .fontWeight(.semibold)

                if dosing.weightBased {
                    Text("(weight-based)")
                        .font(.caption)
                        .foregroundColor(.blue)
                }
            }

            if let maxDose = dosing.maxDose {
                HStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundColor(.orange)
                        .font(.caption)
                    Text("Maximum dose: \(String(format: "%.2f", maxDose)) \(dosing.unit.rawValue)")
                        .font(.caption)
                        .foregroundColor(.orange)
                }
            }

            Text(dosing.instructions)
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.top, 4)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
}
