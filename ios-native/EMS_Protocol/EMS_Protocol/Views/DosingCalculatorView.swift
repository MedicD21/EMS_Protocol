//
//  DosingCalculatorView.swift
//  EMS Protocol
//
//  Created by Claude Code
//

import SwiftUI

struct DosingCalculatorView: View {
    @EnvironmentObject var dosingCalculator: DosingCalculator
    @EnvironmentObject var protocolStore: ProtocolStore
    @State private var selectedMedication: Medication?
    @State private var showingMedicationPicker = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Weight Input Section
                    WeightInputSection()
                        .environmentObject(dosingCalculator)

                    Divider()

                    // Age Group Presets
                    AgeGroupPresetsSection()
                        .environmentObject(dosingCalculator)

                    Divider()

                    // Quick Medication Dosing
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Quick Medication Dosing")
                            .font(.title3)
                            .fontWeight(.semibold)

                        Button(action: { showingMedicationPicker = true }) {
                            HStack {
                                Text(selectedMedication?.name ?? "Select Medication")
                                    .foregroundColor(selectedMedication == nil ? .secondary : .primary)
                                Spacer()
                                Image(systemName: "chevron.down")
                                    .foregroundColor(.secondary)
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                        }

                        if let medication = selectedMedication {
                            MedicationDosingCard(medication: medication)
                                .environmentObject(dosingCalculator)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Dosing Calculator")
            .sheet(isPresented: $showingMedicationPicker) {
                MedicationPickerView(selectedMedication: $selectedMedication)
                    .environmentObject(protocolStore)
            }
        }
    }
}

struct WeightInputSection: View {
    @EnvironmentObject var dosingCalculator: DosingCalculator
    @State private var weightInput = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Patient Weight")
                .font(.title3)
                .fontWeight(.semibold)

            HStack(spacing: 16) {
                TextField("Weight", text: $weightInput)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 120)
                    .onChange(of: weightInput) { newValue in
                        if let weight = Double(newValue) {
                            dosingCalculator.setWeight(weight, unit: dosingCalculator.weightUnit)
                        }
                    }
                    .onAppear {
                        weightInput = String(format: "%.1f", dosingCalculator.patientWeight)
                    }

                Picker("Unit", selection: $dosingCalculator.weightUnit) {
                    Text("kg").tag(WeightUnit.kg)
                    Text("lbs").tag(WeightUnit.lbs)
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(width: 100)
                .onChange(of: dosingCalculator.weightUnit) { _ in
                    dosingCalculator.convertWeight(to: dosingCalculator.weightUnit)
                    weightInput = String(format: "%.1f", dosingCalculator.patientWeight)
                }

                Spacer()
            }

            // Display both units
            VStack(alignment: .leading, spacing: 4) {
                Text("Weight: \(String(format: "%.1f", dosingCalculator.weightInKg)) kg")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text("Weight: \(String(format: "%.1f", dosingCalculator.weightInLbs)) lbs")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
    }
}

struct AgeGroupPresetsSection: View {
    @EnvironmentObject var dosingCalculator: DosingCalculator

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Age Group Presets")
                .font(.title3)
                .fontWeight(.semibold)

            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(AgeGroup.allCases, id: \.self) { ageGroup in
                    Button(action: {
                        dosingCalculator.applyPresetWeight(for: ageGroup)
                    }) {
                        VStack(spacing: 4) {
                            Text(ageGroup.rawValue)
                                .font(.caption)
                                .fontWeight(.medium)

                            Text(presetWeight(for: ageGroup))
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(
                            dosingCalculator.ageGroup == ageGroup ?
                            Color.blue.opacity(0.2) : Color(.systemGray6)
                        )
                        .cornerRadius(8)
                    }
                    .foregroundColor(.primary)
                }
            }
        }
        .padding()
    }

    private func presetWeight(for ageGroup: AgeGroup) -> String {
        switch ageGroup {
        case .neonate: return "~3.5 kg"
        case .infant: return "~7 kg"
        case .child: return "~20 kg"
        case .adolescent: return "~50 kg"
        case .adult: return "~70 kg"
        case .geriatric: return "~70 kg"
        }
    }
}

struct MedicationDosingCard: View {
    let medication: Medication
    @EnvironmentObject var dosingCalculator: DosingCalculator

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(medication.name)
                .font(.headline)

            Text("Generic: \(medication.genericName)")
                .font(.subheadline)
                .foregroundColor(.secondary)

            Divider()

            Text("Calculated Doses for Current Weight:")
                .font(.subheadline)
                .fontWeight(.semibold)

            ForEach(dosingCalculator.calculateAllDoses(for: medication)) { calculation in
                DoseCalculationRow(calculation: calculation)
            }

            if dosingCalculator.calculateAllDoses(for: medication).isEmpty {
                Text("No dosing available for selected age group")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .italic()
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

struct DoseCalculationRow: View {
    let calculation: DoseCalculation

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(calculation.formattedDose)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)

                if calculation.isMaxDoseReached {
                    Text("MAX")
                        .font(.caption2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(Color.red)
                        .cornerRadius(4)
                }

                Spacer()
            }

            Text(calculation.instructions)
                .font(.caption)
                .foregroundColor(.secondary)

            if let warning = calculation.warning {
                HStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundColor(.orange)
                    Text(warning)
                        .font(.caption)
                        .foregroundColor(.orange)
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
    }
}

struct MedicationPickerView: View {
    @EnvironmentObject var protocolStore: ProtocolStore
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedMedication: Medication?
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            List(filteredMedications) { medication in
                Button(action: {
                    selectedMedication = medication
                    presentationMode.wrappedValue.dismiss()
                }) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(medication.name)
                            .font(.headline)

                        Text(medication.genericName)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 4)
                }
            }
            .navigationTitle("Select Medication")
            .navigationBarItems(trailing: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            })
            .searchable(text: $searchText, prompt: "Search medications")
        }
    }

    private var filteredMedications: [Medication] {
        if searchText.isEmpty {
            return protocolStore.medications.sorted { $0.name < $1.name }
        }
        return protocolStore.medications.filter {
            $0.name.localizedCaseInsensitiveContains(searchText) ||
            $0.genericName.localizedCaseInsensitiveContains(searchText)
        }.sorted { $0.name < $1.name }
    }
}
